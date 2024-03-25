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
            // str.setConStr("QL_TRUONGHOC_X", "123");

            OracleConnection con = new OracleConnection(new CONNECTIONSTRING().getString());

            try
            {
                con.Open();
                con.Close();

                //role_management obj = new role_management();
                //obj.Show();
                MessageBox.Show("Login successful.");
                this.Hide();

            }
            catch (Exception ex)
            {
                con.Close();
                MessageBox.Show("Invalid name or password.");
            }
          
        }
    }
}



