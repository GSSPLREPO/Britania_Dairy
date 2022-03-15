using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Powder_MISProduct.Common
{
    public class Controls
    {
        public void ClearForm(Control Container)
        {
            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    ClearForm(ctrl);
                }
                if (ctrl is TextBox)
                {
                    ((TextBox)ctrl).Text = "";
                }
                if (ctrl is DropDownList)
                {
                    ((DropDownList)ctrl).SelectedIndex = -1;
                }
                if (ctrl is RadioButton)
                {
                    ((RadioButton)ctrl).Checked = false;
                }
                if (ctrl is RadioButtonList)
                {
                    ((RadioButtonList)ctrl).SelectedIndex = -1;
                }
                if (ctrl is CheckBox)
                {
                    ((CheckBox)ctrl).Checked = false;
                }
                if (ctrl is CheckBoxList)
                {
                    ((CheckBoxList)ctrl).SelectedIndex = -1;
                }
                if (ctrl is HtmlInputHidden)
                {
                    ((HtmlInputHidden)ctrl).Value = "";
                }

            }
        }
        public void ValidatorsHandle(Control Container)
        {
            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    ValidatorsHandle(ctrl);
                }
                if (ctrl is RequiredFieldValidator)
                {
                    ((RequiredFieldValidator)ctrl).Enabled = true;
                    ((RequiredFieldValidator)ctrl).Text = "*";
                }
                if (ctrl is CompareValidator)
                {
                    ((CompareValidator)ctrl).Enabled = true;
                    ((CompareValidator)ctrl).Text = "*";
                }
                if (ctrl is RegularExpressionValidator)
                {
                    ((RegularExpressionValidator)ctrl).Enabled = true;
                    ((RegularExpressionValidator)ctrl).Text = "*";
                }
                if (ctrl is CustomValidator)
                {
                    ((CustomValidator)ctrl).Enabled = true;
                    ((CustomValidator)ctrl).Text = "*";
                }
            }
        }

        public void DisableValidatorsHandle(Control Container)
        {
            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    DisableValidatorsHandle(ctrl);
                }
                if (ctrl is RequiredFieldValidator)
                {
                    ((RequiredFieldValidator)ctrl).Enabled = true;
                    ((RequiredFieldValidator)ctrl).Text = "";
                }
                if (ctrl is CompareValidator)
                {
                    ((CompareValidator)ctrl).Enabled = true;
                    ((CompareValidator)ctrl).Text = "";
                }
                if (ctrl is RegularExpressionValidator)
                {
                    ((RegularExpressionValidator)ctrl).Enabled = true;
                    ((RegularExpressionValidator)ctrl).Text = "";
                }
                if (ctrl is CustomValidator)
                {
                    ((CustomValidator)ctrl).Enabled = true;
                    ((CustomValidator)ctrl).Text = "";
                }
            }
        }
        public void ClearFormWithoutReadOnlyControl(Control Container)
        {
            foreach (Control ctrl in Container.Controls)
            {
                //if (Container.Controls.Count > 0)
                //{
                //    ClearForm(ctrl);
                //}
                if (ctrl is TextBox)
                {
                    if (((TextBox)ctrl).ReadOnly == false)
                    {
                        ((TextBox)ctrl).Text = "";
                    }
                }

            }
        }




        public void EnableControls(Control Container)
        {
            Color bkcolor = Color.White;

            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    EnableControls(ctrl);
                }
                if (ctrl is Panel)
                {
                    EnableControls(ctrl);
                }
                if (ctrl is TextBox)
                {
                    //if (((TextBox)ctrl).ReadOnly == false)
                    //{
                    //    ((TextBox)ctrl).Enabled = true;
                    //    ((TextBox)ctrl).BackColor = bkcolor;
                    //}
                    ((TextBox)ctrl).ReadOnly = false;
                    ((TextBox)ctrl).BackColor = bkcolor;
                }
                if (ctrl is DropDownList)
                {
                    ((DropDownList)ctrl).Enabled = true;
                    ((DropDownList)ctrl).BackColor = bkcolor;
                }
                if (ctrl is FileUpload)
                {
                    ((FileUpload)ctrl).Enabled = true;
                    ((FileUpload)ctrl).BackColor = bkcolor;
                }
            }
        }

        public void DisableControls(Control Container)
        {
            //Color bkcolor = System.Drawing.Color.Gainsboro;
            Color bkcolor = Color.LightSteelBlue;
            Color forecolor = Color.Black;
            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    DisableControls(ctrl);
                }
                if (ctrl is Panel)
                {
                    DisableControls(ctrl);
                }
                if (ctrl is TextBox)
                {
                    ((TextBox)ctrl).BackColor = bkcolor;
                    ((TextBox)ctrl).ForeColor = forecolor;
                    ((TextBox)ctrl).ReadOnly = true;


                }
                if (ctrl is DropDownList)
                {
                    ((DropDownList)ctrl).Enabled = false;
                    ((DropDownList)ctrl).BackColor = bkcolor;
                }
                if (ctrl is FileUpload)
                {
                    ((FileUpload)ctrl).Enabled = false;
                    ((FileUpload)ctrl).BackColor = bkcolor;
                }
            }
        }
        public void BindDropDown_ListBox(DataTable dt, Control ctrl, string DataTextField, string DataValueField)
        {
            if (ctrl is DropDownList)
            {
                ((DropDownList)ctrl).DataSource = dt;
                ((DropDownList)ctrl).DataTextField = DataTextField;
                ((DropDownList)ctrl).DataValueField = DataValueField;
                ((DropDownList)ctrl).DataBind();

            }
            else if (ctrl is ListBox)
            {
                ((ListBox)ctrl).DataSource = dt;
                ((ListBox)ctrl).DataTextField = DataTextField;
                ((ListBox)ctrl).DataValueField = DataValueField;
                ((ListBox)ctrl).DataBind();
            }
            else if (ctrl is CheckBoxList)
            {
                ((CheckBoxList)ctrl).DataSource = dt;
                ((CheckBoxList)ctrl).DataTextField = DataTextField;
                ((CheckBoxList)ctrl).DataValueField = DataValueField;
                ((CheckBoxList)ctrl).DataBind();
            }
            else if (ctrl is RadioButtonList)
            {
                ((RadioButtonList)ctrl).DataSource = dt;
                ((RadioButtonList)ctrl).DataTextField = DataTextField;
                ((RadioButtonList)ctrl).DataValueField = DataValueField;
                ((RadioButtonList)ctrl).DataBind();
            }
        }
        public void SetButtonAttributes(Control Box)
        {
            foreach (Control ctrl in Box.Controls)
            {
                if (ctrl is Button)
                {
                    ((Button)ctrl).Attributes.Add("onmouseenter", "this.style.cursor='Hand';this.style.color='#6E9297';");
                    ((Button)ctrl).Attributes.Add("onmouseout", "this.style.cursor='Hand';this.style.color='#86A7AB';");
                }
            }
        }
        public string ConvertToCurrancy(string amount)
        {
            return String.Format("{0:##,##0.00}", Convert.ToDouble(amount));
        }

        public void ReadOnly(Control Container)
        {
            Color bkcolor = Color.LightSteelBlue;
            Color forecolor = Color.Black;

            foreach (Control ctrl in Container.Controls)
            {
                //if(ctrl.Controls.IsReadOnly == true)

                if (Container.Controls.Count > 0)
                {
                    ReadOnly(ctrl);
                }
                if (ctrl is Panel)
                {
                    ReadOnly(ctrl);
                }
                if (ctrl is TextBox)
                {
                    if (((TextBox)ctrl).ReadOnly == true)
                    {
                        ((TextBox)ctrl).BackColor = bkcolor;
                        ((TextBox)ctrl).ForeColor = forecolor;
                    }

                }


            }


        }

        #region ToTitleCase
        /// <summary>
        /// Change the case of the first letter of each word to upper case.
        /// </summary>
        /// <param name="text">The string to convert to title case.</param>
        /// <returns>The string in title case.</returns>
        public string ToTitleCase(string text)
        {
            return ToTitleCase(text, Thread.CurrentThread.CurrentCulture, false);
        }
        /// <summary>
        /// Change the case of the first letter of each word to upper case.
        /// </summary>
        /// <param name="text">The string to convert to title case.</param>
        /// <param name="forceCasing">When true, forces all words to be lower case before changing everything to title case.</param>
        /// <returns>The string in title case.</returns>
        public string ToTitleCase(string text, bool forceCasing)
        {
            return ToTitleCase(text, Thread.CurrentThread.CurrentCulture, forceCasing);
        }
        /// <summary>
        /// Change the case of the first letter of each word to upper case.
        /// </summary>
        /// <param name="text">The string to convert to title case.</param>
        /// <param name="culture">The culture information to be used.</param>
        /// <param name="forceCasing">When true, forces all words to be lower case before changing everything to title case.</param>
        /// <returns>The string in title case.</returns>
        private string ToTitleCase(string text, CultureInfo culture, bool forceCasing)
        {
            if (forceCasing)
            {
                return culture.TextInfo.ToTitleCase(text.ToLower());
            }
            return culture.TextInfo.ToTitleCase(text);
        }
        #endregion

        #region
        public void ClearFormReadOnly(Control Container)
        {
            foreach (Control ctrl in Container.Controls)
            {
                if (Container.Controls.Count > 0)
                {
                    ClearFormReadOnly(ctrl);
                }
                if (ctrl is TextBox)
                {
                    ((TextBox)ctrl).ReadOnly = true;
                }
                if (ctrl is DropDownList)
                {
                    ((DropDownList)ctrl).Enabled = false;
                }
                if (ctrl is RadioButtonList)
                {
                    ((RadioButtonList)ctrl).Enabled = false;
                }
                if (ctrl is Panel)
                {
                    ((Panel)ctrl).Enabled = false;
                }

                //if (ctrl is HtmlInputHidden)
                //{
                //    ((HtmlInputHidden)ctrl).Value = "";
                //}

            }
        }
        #endregion
    }
}
