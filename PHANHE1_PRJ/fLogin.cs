using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Oracle.ManagedDataAccess.Client;

namespace PHANHE1_PRJ
{
    public partial class fLogin : Form
    {
        CONNECTIONSTRING str = new CONNECTIONSTRING();
        public fLogin()
        {
            InitializeComponent();

        }

        private void P_USERNAME_TextChanged(object sender, EventArgs e)
        {
        }

        private void bt_DANGNHAP_Click(object sender, EventArgs e)
        {
             str.setConStr(P_USERNAME.Text, P_PASSWORD.Text);
            // str.setConStr("X_NS010", "123"); // Nhan vien co ban
            // str.setConStr("X_NS002", "123"); // Truong don vi
            // str.setConStr("X_NS038", "123"); // Giang vien
            // str.setConStr("X_NS101", "123"); // Giao vu

            // str.setConStr("X_SV000422", "123"); // Giao vu



            OracleConnection con = new OracleConnection(new CONNECTIONSTRING().getString());

            try
            {
                con.Open();
                con.Close();

                fDashboardUser dashboard = new fDashboardUser(con);
                MessageBox.Show("Login successful.");
                this.Hide();
                dashboard.ShowDialog();
                this.Show();
            }
            catch (Exception ex)
            {
                con.Close();
                MessageBox.Show("Invalid name or password.");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}



