using Powder_MISProduct.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Powder_MISProduct.DataAccess
{
  public  class DatabaseTransaction
    {
        #region Declaration of static variables
        /// <summary>
        /// Declaration of static variables
        /// </summary>

        Encryption objEncryption = new Encryption();
        public static readonly string mstrConnString = Encryption.Decrypt_Static(System.Configuration.ConfigurationSettings.AppSettings["DBConnString"]);
        public static SqlConnection connection = new SqlConnection(mstrConnString);
        public static SqlCommand command = new SqlCommand();
        public static SqlTransaction transaction = default(SqlTransaction);
        #endregion

        #region Transaction
        /// <summary>
        /// To Open Connection and begin transaction while inserting data in the 1st table.
        /// </summary>
        public static void OpenConnectionTransation()
        {
            //if the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            //associate the connection with the command
            command.Connection = connection;

            //Begin the SqlTransaction 
            transaction = connection.BeginTransaction(IsolationLevel.ReadCommitted);
        }
        #endregion

        #region Commiting Transaction
        /// <summary>
        /// Commit transaction when process of inserting data in table is completed.
        /// Close connection after commit command executes.
        /// </summary>
        public static void CommitTransation()
        {
            transaction.Commit();
            connection.Close();
        }
        #endregion

        #region Rollback Transaction
        /// <summary>
        /// If error occurs while inserting data in tables, transaction should be Rollback.
        /// Close Connection after rollback command executes.
        /// </summary>
        public static void RollbackTransation()
        {
            transaction.Rollback();
            connection.Close();
        }
        #endregion

        #region "parameter Attaching"
        /// <summary>
        /// This method is used to attach array of SqlParameters to a SqlCommand.
        /// This method will assign a value of DbNull to any parameter with a direction of
        /// InputOutput and a value of null.  
        /// 
        /// This behavior will prevent default values from being used, but
        /// this will be the less common case than an intended pure output parameter (derived as InputOutput)
        /// where the user provided no input value.
        /// 
        /// </summary>
        /// <param name="command">The command to which the parameters will be added</param>
        /// <param name="commandParameters">an array of SqlParameters tho be added to command</param>
        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            foreach (SqlParameter p in commandParameters)
            {
                //check for derived output value with no value assigned
                if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                {
                    p.Value = DBNull.Value;
                }

                command.Parameters.Add(p);
            }
        }
        #endregion

        #region "Assigning Parameter Values"
        /// <summary>
        /// This method assigns an array of values to an array of SqlParameters.
        /// </summary>
        /// <param name="commandParameters">array of SqlParameters to be assigned values</param>
        /// <param name="parameterValues">array of objects holding the values to be assigned</param>
        private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
        {
            if ((commandParameters == null) || (parameterValues == null))
            {
                //do nothing if we get no data
                return;
            }
            // we must have the same number of values as we have parameters to put them in
            if (commandParameters.Length != parameterValues.Length)
            {
                throw new ArgumentException("Parameter count does not match Parameter Value count.");
            }
            //iterate through the SqlParameters, assigning the values from the corresponding position in the 
            //value array
            for (int i = 0, j = commandParameters.Length; i < j; i++)
            {
                commandParameters[i].Value = parameterValues[i];
            }
        }
        #endregion

        #region "Prepare Command overloaded"
        /// <summary>
        /// This method opens (if necessary) 
        /// and assigns a connection, transaction, command type and parameters 
        /// to the provided command.
        /// </summary>
        /// <param name="command">the SqlCommand to be prepared</param>
        /// <param name="connection">a valid SqlConnection, on which to execute this command</param>
        /// <param name="transaction">a valid SqlTransaction, or 'null'</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParameters to be associated with the command or 'null' if no parameters are required</param>
        private static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters)
        {
            //if the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            //associate the connection with the command
            command.Connection = connection;

            //set the command text (stored procedure name or SQL statement)
            command.CommandText = commandText;

            //if we were provided a transaction, assign it.
            if (transaction != null)
            {
                command.Transaction = transaction;
            }

            //set the command type
            command.CommandType = commandType;

            //attach the command parameters if they are provided
            if (commandParameters != null)
            {
                AttachParameters(command, commandParameters);
            }

            return;
        }
        #endregion

        #region "Execute Non Query (overloaded) "
        /// <summary>
        /// Execute a stored procedure via a SqlCommand (that returns no resultset) against the database specified in 
        /// the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        /// stored procedure (the first time each stored procedure is called), and assign the values based on parameter order.
        /// This method provides no access to output parameters or the stored procedure's return value parameter.
        /// <code>int result = ExecuteNonQuery(connString, "PublishOrders", 24, 36);</code>		
        /// </summary>		
        /// <param name="spName">the name of the stored prcedure</param>
        /// <param name="parameterValues">an array of objects to be assigned as the input values of the stored procedure</param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteNonQuery(CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteNonQuery(CommandType.StoredProcedure, spName);
            }
        }
        #endregion

        #region "Execute Non Query (returns int)"
        /// <summary>
        /// Could be used for Inline Query (Changed By Niketa on 22/06/2011)
        /// Execute a SqlCommand (that returns no resultset) against the database 
        /// specified in the connection string 
        /// using the provided parameters.
        /// <code>
        /// int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
        /// </code>		
        /// </summary>				
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //call the overload that takes a connection in place of the connection string
            return ExecuteNonQuery(connection, commandType, commandText, commandParameters);

        }
        #endregion

        #region "Exeute Non Query (Overloaded )"
        /// <summary>
        /// Execute a SqlCommand (that returns no resultset) against the specified SqlConnection 
        /// using the provided parameters.		
        /// <code>int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="connection">a valid SqlConnection </param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {

            PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);

            //finally, execute the command.
            int retval;
            retval = command.ExecuteNonQuery();

            // detach the SqlParameters from the command object, so they can be used again.
            command.Parameters.Clear();
            return retval;
        }
        #endregion

        #region "Executing A DataTable from a SQL Statement"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the 
        /// database specified in the connection string 
        /// using the provided parameters.
        /// <code>DataTable dt = ExecuteDataTable(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns a DataTable containing the resultset generated by the command</returns>
        public static DataTable ExecuteDataTable(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            ////create & open a SqlConnection, and dispose of it after we are done.
            //using (SqlConnection cn = new SqlConnection(mstrConnString))
            //{
            //    cn.Open();

            //call the overload that takes a connection in place of the connection string
            return ExecuteDataTable(connection, commandType, commandText, commandParameters);
            //}
        }
        #endregion

        #region "Executing a DataTable against a SQL Query"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>DataTable dt = ExecuteDataTable(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="connection">a valid SqlConnection</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns a DataTable containing the resultset generated by the command</returns>
        public static DataTable ExecuteDataTable(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, transaction, commandType, commandText, commandParameters);

            //create the DataAdapter & DataTable
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            //fill the DataTable using default values for DataTable names, etc.
            da.Fill(dt);

            // detach the SqlParameters from the command object, so they can be used again.			
            cmd.Parameters.Clear();

            //return the DataTable
            return dt;
        }
        #endregion
    }
}
