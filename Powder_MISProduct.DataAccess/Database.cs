using Powder_MISProduct.Common;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Powder_MISProduct.DataAccess
{
    public class Database
    {
        /// <summary>
        /// Static Connection string variable
        /// </summary>
        /// 

        //Encryption objEncryption = new Encryption();
        public static readonly string mstrConnString = Encryption.Decrypt_Static(System.Configuration.ConfigurationSettings.AppSettings["DBConnString"]);
        //public static readonly string mstrConnString = System.Configuration.ConfigurationSettings.AppSettings["DBConnString"];



        #region "Custom Routines & Functions"

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
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteNonQuery(cn, commandType, commandText, commandParameters);
            }
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
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();

            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
            //finally, execute the command.

            int retval;
            //= cmd.ExecuteNonQuery();
            retval = cmd.ExecuteNonQuery();
            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
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
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteDataTable(cn, commandType, commandText, commandParameters);
            }
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
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

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

        #region "Getting a single Result from a SQL Query (ExecuteScalar)"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the database specified in the connection string 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(connString, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteScalar(cn, commandType, commandText, commandParameters);
            }
        }
        #endregion

        #region "Getting a single value againt a SQL Query"
        /// <summary>
        /// Execute a stored procedure via a SqlCommand (that returns a 1x1 resultset) against the database specified in 
        /// the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        /// stored procedure (the first time each stored procedure is called), and assign the values based on parameter order. 
        /// This method provides no access to output parameters or the stored procedure's return value parameter.
        /// <code>int orderCount = (int)ExecuteScalar(connString, "GetOrderCount", 24, 36);</code>
        /// </summary>		
        /// <param name="spName">the name of the stored procedure</param>
        /// <param name="parameterValues">an array of objects to be assigned as the input values of the stored procedure </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteScalar(CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteScalar(CommandType.StoredProcedure, spName);
            }
        }
        #endregion

        #region "Executing a SQL Command and returning a single value"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code> 
        /// </summary>
        /// <param name="connection">a valid SqlConnection </param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
            //execute the command & return the results
            object retval = cmd.ExecuteScalar();
            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;
        }

        #endregion

        #region "-Getting DataTable from SqlQuery"

        private DataTable GetDataTable(SqlCommand ObjSqlCmd)
        {
            ObjSqlCmd.Connection.Open();
            SqlDataAdapter objSqladp = new SqlDataAdapter(ObjSqlCmd);
            try
            {
                DataTable objresdt = new DataTable();
                objSqladp.Fill(objresdt);
                return objresdt;
            }
            finally
            {
                ObjSqlCmd.Connection.Close();
            }
        }

        #endregion

        #region DataSet
        /// <summary>
        /// For Getting mutiple tables from Stored Procedures.
        /// </summary>		

        #region "Executing A DataSet from a SQL Statement"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the 
        /// database specified in the connection string 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataSet(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns a DataSet containing the resultset generated by the command</returns>
        public static DataSet ExecuteDataSet(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteDataSet(cn, commandType, commandText, commandParameters);
            }
        }
        #endregion

        #region "Executing a DataSet against a SQL Query"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataSet(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="connection">a valid SqlConnection</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns a DataSet containing the resultset generated by the command</returns>
        public static DataSet ExecuteDataSet(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            cmd.CommandTimeout = 60000;

            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //create the DataAdapter & DataSet
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            //fill the DataSet using default values for DataSet names, etc.
            da.Fill(ds);

            // detach the SqlParameters from the command object, so they can be used again.			
            cmd.Parameters.Clear();

            //return the DataSet
            return ds;
        }
        #endregion
        #endregion


        #endregion
    }
    #region "Class SqlHelperParameterCache"
    /// <summary>
    /// SqlHelperParameterCache provides functions to leverage a static cache of procedure parameters, and the
    /// ability to discover parameters for stored procedures at run-time.
    /// </summary>
    public sealed class SqlHelperParameterCache
    {
        /// <summary>
        /// Conenction String For DB Access (!!!)
        /// </summary>
        //public static readonly string mstrConnString=System.Configuration.ConfigurationSettings.AppSettings["ConnString"];
        public static readonly string mstrConnString = Encryption.Decrypt_Static(System.Configuration.ConfigurationSettings.AppSettings["DBConnString"]);

        #region "Constructors and members"
        /// <summary>
        /// Since this class provides only static methodt, make the default constructor 
        /// private to prevent  
        /// instances from being created with "new SqlHelperParameterCache()".
        /// </summary>
        private SqlHelperParameterCache() { }

        /// <summary>
        /// Cache object for managing parameters
        /// </summary>
        private static Hashtable paramCache = Hashtable.Synchronized(new Hashtable());
        #endregion

        #region "Getting SQL Parameterset"
        /// <summary>
        /// resolve at run time the appropriate set of SqlParameters for a stored procedure
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <param name="includeReturnValueParameter">whether or not to include their return value parameter </param>
        /// <returns>Array of SQL Parameters</returns>
        private static SqlParameter[] DiscoverSpParameterSet(string spName, bool includeReturnValueParameter)
        {
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            using (SqlCommand cmd = new SqlCommand(spName, cn))
            {
                cn.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                SqlCommandBuilder.DeriveParameters(cmd);

                if (!includeReturnValueParameter)
                {
                    cmd.Parameters.RemoveAt(0);
                }

                SqlParameter[] discoveredParameters = new SqlParameter[cmd.Parameters.Count]; ;

                cmd.Parameters.CopyTo(discoveredParameters, 0);

                return discoveredParameters;
            }
        }
        #endregion

        #region "Cloning parameters"
        /// <summary>
        /// Cloning parameters (Coping parameters into new parameter sets)
        /// </summary>
        /// <param name="originalParameters">Array of SQL parameters</param>
        /// <returns>Array of SQL parameters</returns>
        private static SqlParameter[] CloneParameters(SqlParameter[] originalParameters)
        {
            //deep copy of cached SqlParameter array
            SqlParameter[] clonedParameters = new SqlParameter[originalParameters.Length];

            for (int i = 0, j = originalParameters.Length; i < j; i++)
            {
                clonedParameters[i] = (SqlParameter)((ICloneable)originalParameters[i]).Clone();
            }
            return clonedParameters;
        }
        #endregion

        #region "Add Parameter to cache"
        /// <summary>
        ///	add parameter array to the cache
        /// </summary>		
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters to be cached </param>
        public static void CacheParameterSet(string commandText, params SqlParameter[] commandParameters)
        {
            string hashKey = mstrConnString + ":" + commandText;

            paramCache[hashKey] = commandParameters;
        }
        #endregion

        #region "Extract Array of SP Parameters from Cache"
        /// <summary>
        /// Retrieve a parameter array from the cache 
        /// </summary>		
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <returns>returns an array of SqlParamters</returns>
        public static SqlParameter[] GetCachedParameterSet(string commandText)
        {
            string hashKey = mstrConnString + ":" + commandText;

            SqlParameter[] cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                return null;
            }
            else
            {
                return CloneParameters(cachedParameters);
            }
        }
        #endregion

        #region "Get Stored Proc Parameter Set as an Array"
        /// <summary>
        /// Retrieves the set of SqlParameters appropriate for the stored procedure 
        /// This method will query the database for this information, and then store it in a cache for future requests.
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <returns>returns an array of SqlParameters</returns>
        public static SqlParameter[] GetSpParameterSet(string spName)
        {
            return GetSpParameterSet(spName, false);
        }
        #endregion

        #region "Get SQL parameterset as a SQL Parameter Array"
        /// <summary>
        /// Retrieves the set of SqlParameters appropriate for the stored procedure 
        /// This method will query the database for this information, and then store it in a cache for future requests.
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <param name="includeReturnValueParameter">a bool value indicating whether the return value parameter should be included in the results </param>
        /// <returns>returns an array of SqlParameters</returns>
        public static SqlParameter[] GetSpParameterSet(string spName, bool includeReturnValueParameter)
        {
            string hashKey = mstrConnString + ":" + spName + (includeReturnValueParameter ? ":include ReturnValue Parameter" : "");

            SqlParameter[] cachedParameters;

            cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                cachedParameters = (SqlParameter[])(paramCache[hashKey] = DiscoverSpParameterSet(spName, includeReturnValueParameter));
            }

            return CloneParameters(cachedParameters);
        }
        #endregion

    }
    #endregion

}
