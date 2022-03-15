using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Powder_MISProduct.Common
{
    public class UniqueArrayList : ArrayList
    {
        public delegate void ListEmptiedHandler(object sender, EventArgs e);

        /// <summary>
        /// event for notifying that list has become empty
        /// </summary>
        public event ListEmptiedHandler ListEmpty;

        protected virtual void OnListEmpty(EventArgs e)
        {
            if (ListEmpty != null)
                ListEmpty(this, e);
        }


        /// <summary>
        /// constructor
        /// </summary>
        public UniqueArrayList()
        {
        }

        /// <summary>
        /// initialize object with given CSV
        /// </summary>
        /// <param name="csvRange"></param>
        public UniqueArrayList(string csvRange)
        {
            string[] strValues = csvRange.Split(',');
            foreach (string strVal in strValues)
                base.Add(strVal);
        }


        /// <summary>
        /// initialize object with given the given column of a datatable
        /// </summary>
        /// <param name="csvRange"></param>
        public UniqueArrayList(System.Data.DataTable sourceTable, string columnName)
        {
            foreach (DataRow dr in sourceTable.Rows)
                base.Add(dr[columnName]);
        }


        /// <summary>
        /// add an item to array list
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public override int Add(object value)
        {
            if (!base.Contains(value))
                return base.Add(value);
            else
                return 0;
        }

        /// <summary>
        /// convert array list to CSV
        /// </summary>
        /// <returns></returns>
        public string GetCSV()
        {
            string strCSV = "";
            foreach (object obj in base.ToArray())
                strCSV += "," + obj.ToString();
            if (strCSV != "")
                strCSV = strCSV.Remove(0, 1);
            return strCSV;

        }

        /// <summary>
        /// overrides base Clear() method and raises ListEmpty event
        /// </summary>
        public override void Clear()
        {
            base.Clear();
            OnListEmpty(EventArgs.Empty);
        }

        /// <summary>
        /// overrides base Remove() method and raises ListEmpty event
        /// </summary>
        public override void Remove(object value)
        {
            base.Remove(value);
            if (base.Count == 0)//list has become empty
                OnListEmpty(EventArgs.Empty);
        }


        /// <summary>
        /// overrides base RemoveAt() method and raises ListEmpty event
        /// </summary>
        public override void RemoveAt(int index)
        {
            base.RemoveAt(index);
            if (base.Count == 0)//list has become empty
                OnListEmpty(EventArgs.Empty);
        }


        /// <summary>
        /// overrides base RemoveRange() method and raises ListEmpty event
        /// </summary>
        public override void RemoveRange(int index, int count)
        {
            base.RemoveRange(index, count);
            if (base.Count == 0)//list has become empty
                OnListEmpty(EventArgs.Empty);
        }

        /// <summary>
        /// Converts list to a string array
        /// </summary>
        /// <returns>string[]</returns>
        public string[] ToStringArray()
        {
            return (string[])base.ToArray(Type.GetType("System.String"));
        }
    }
}
