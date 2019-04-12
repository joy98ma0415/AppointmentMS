using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AppointmentMS
{
    public partial class _Default : Page
    {
        private DataSet objDS;
        private SqlDataAdapter objAdapter;
        private DataTable appTable;

        private string strDbCon;

        protected void Page_Load(object sender, EventArgs e)
        {
            strDbCon = @"Data Source=azurewebapplication.database.windows.net;Initial Catalog=webapp;User ID=joy51744;Password=Joy98ma0415;Connect Timeout=60;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            string strSQL;
            TextBoxName.Enabled = false;
            TextBoxID.Enabled = false;
            TextBoxDOB.Enabled = false;
            TextBoxAddress.Enabled = false;
            TextBoxPostCode.Enabled = false;
            TextBoxPhone.Enabled = false;
            LabelMessage.Text = "診所的所有預約資訊";
            SqlConnection objCon = new SqlConnection(strDbCon);
            objCon.Open();
            objDS = new DataSet();
            strSQL = "SELECT * FROM Aptment";
            objAdapter = new SqlDataAdapter(strSQL, objCon);
            objAdapter.Fill(objDS, "Aptment");
            appTable = objDS.Tables["Aptment"];

            if (!IsPostBack)
            {
                FillPatientInfo();
                DateTime selectedDate = DateTime.Now.AddHours(08);
                CalendarDentist.SelectedDate = getFreeDate(selectedDate);
            }
            else
            {
                GridViewAppointment.DataBind();
            }
            objCon.Close();
        }

        private DateTime getFreeDate(DateTime selectedDate)
        {
            if (appTable.Rows.Count > 0)
            {
                DateTime tDate;
                Boolean isOKDate = false;
                while (!isOKDate)
                {
                    isOKDate = true;

                    foreach (DataRow tRow in appTable.Rows)
                    {
                        tDate = Convert.ToDateTime(tRow["DateOfAptment"]);
                        if (tDate.Date == selectedDate.Date)
                        {
                            isOKDate = false;
                            selectedDate = selectedDate.AddDays(1);
                        }
                    }
                }
            }
            return selectedDate;
        }

        private void FillPatientInfo()
        {
            DropDownListPatient.Items.Clear();
            string strSQL;
            SqlConnection objCon = new SqlConnection(strDbCon);
            strSQL = "SELECT PatientID, Name FROM Patient";
            SqlCommand objCmd = new SqlCommand(strSQL, objCon);
            SqlDataReader objDR;
            ListItem newItem01 = new ListItem();
            newItem01.Text = "選擇病人姓名";
            newItem01.Value = "0";
            DropDownListPatient.Items.Add(newItem01);
            try
            {
                objCon.Open();
                objDR = objCmd.ExecuteReader();
                while (objDR.Read())
                {
                    ListItem newItem = new ListItem();
                    newItem.Text = objDR["Name"].ToString();
                    newItem.Value = objDR["PatientID"].ToString();
                    DropDownListPatient.Items.Add(newItem);
                }
                objDR.Close();
            }
            catch (Exception ex)
            {
                LabelMessage.Text = "錯誤！無法讀取姓名清單";
                LabelMessage.Text += ex.Message;
            }
            finally
            {
                objCon.Close();
            }
        }

        protected void DropDownListPatient_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strSQL;
            if (Convert.ToInt32(DropDownListPatient.SelectedItem.Value) > 0)
            {
                SqlConnection objCon = new SqlConnection(strDbCon);
                strSQL = "SELECT * FROM Patient WHERE PatientID = '" + DropDownListPatient.SelectedItem.Value + "'";
                SqlCommand objCmd = new SqlCommand(strSQL, objCon);
                SqlDataReader objDR;
                try
                {
                    objCon.Open();
                    objDR = objCmd.ExecuteReader();
                    objDR.Read();
                    TextBoxID.Text = objDR["PatientID"].ToString();
                    TextBoxName.Text = objDR["Name"].ToString();
                    TextBoxDOB.Text = objDR["DateOfBirth"].ToString();
                    TextBoxAddress.Text = objDR["Address"].ToString();
                    TextBoxPostCode.Text = objDR["PostCode"].ToString();
                    TextBoxPhone.Text = objDR["Phone"].ToString();
                    objDR.Close();
                }
                catch (Exception ex)
                {
                    LabelMessage.Text = "錯誤！無法讀取病人資料！" + ex.ToString();
                }
                finally
                {
                    objCon.Close();
                }
            }
            else
            {
                TextBoxName.Text = "";
                TextBoxDOB.Text = "";
                TextBoxAddress.Text = "";
                TextBoxPostCode.Text = "";
                TextBoxPhone.Text = "";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strSQL;
            SqlConnection objCon = new SqlConnection(strDbCon);
            // 建立插入記錄的SQL指令
            strSQL = "INSERT INTO Aptment (";
            strSQL += "PatientID, DateOfAptment, Time) ";
            strSQL += "VALUES (" + TextBoxID.Text + ",";
            strSQL += "'" + CalendarDentist.SelectedDate.ToShortDateString();
            strSQL += "','" + DropDownListApointment.SelectedItem.Value + "')";
            SqlCommand objCmd = new SqlCommand(strSQL, objCon);
            int affectedRows = 0;
            try
            {
                objCon.Open();
                // 執行SQL指令新增記錄
                affectedRows = objCmd.ExecuteNonQuery();
                LabelMessage.Text = affectedRows + "筆記錄完成預約!";
                Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                LabelMessage.Text = "對不起! 無法執行你的操作 " + ex.ToString();
            }
            finally { objCon.Close(); }
        }

        protected void CalendarDentist_DayRender(object sender, DayRenderEventArgs e)
        {
            if (appTable.Rows.Count > 0)
            {
                DateTime tDate;
                foreach (DataRow tRow in appTable.Rows)
                {
                    tDate = Convert.ToDateTime(tRow["DateOfAptment"]);
                    if (tDate.Date == e.Day.Date)
                    {
                        e.Cell.BackColor = System.Drawing.Color.Cyan;
                        Label lbl = new Label();
                        lbl.Text = "<br/>有預約！";
                        if (e.Cell.Controls.Count <= 1)
                        {
                            e.Cell.Controls.Add(lbl);
                        }
                    }
                }
            }
        }

        protected void CalendarDentist_SelectionChanged(object sender, EventArgs e)
        {
            DateTime selectDate = CalendarDentist.SelectedDate;
            CalendarDentist.SelectedDate = getFreeDate(selectDate);
            switch (CalendarDentist.SelectedDate.DayOfWeek)
            {
                case DayOfWeek.Sunday:
                    DropDownListApointment.Items.Add("10:00");
                    DropDownListApointment.Items.Add("10:30");
                    DropDownListApointment.Items.Add("11:00");
                    DropDownListApointment.Items.Add("11:30");
                    break;

                default:
                    DropDownListApointment.Items.Add("12:30");
                    DropDownListApointment.Items.Add("13:30");
                    DropDownListApointment.Items.Add("14:30");
                    DropDownListApointment.Items.Add("15:30");
                    DropDownListApointment.Items.Add("16:30");
                    break;
            }
        }

        protected void GridViewAppointment_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}