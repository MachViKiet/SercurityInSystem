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
    public partial class fDangKyHocPhan : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fDangKyHocPhan(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();

            bool init = true;
            if (!init)
            {
                this.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.SV_DANGKY_HOCPHAN(:P_MASV,:P_MAGV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv.Text));
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));
            Console.WriteLine("Query: " + command.Parameters);
            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Update Success");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.SV_DANGKY_HOCPHAN(:P_MASV,:P_MAGV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv.Text));
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));
            Console.WriteLine("Query: " + command.Parameters);
            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Update Success");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
