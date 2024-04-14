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
    public partial class fGiangVien : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }

        public fGiangVien(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
            bool init = display_table_DS_SINHVIEN() && display_table_DS_PHANCONG();

            if (!init)
            {
                this.Close();
            }
        }

        private bool display_table_DS_PHANCONG()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.PHANCONG_MY_INFO", connect);
                adpt.Fill(dt);
                dataGridView_PHANCONG.DataSource = dt;
                connect.Close();
            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;
            }
            return true;
        }

        private bool display_table_DS_SINHVIEN()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.DK_MY_CLASSES", connect);
                adpt.Fill(dt);
                dataGridView_SINHVIEN.DataSource = dt;
                connect.Close();
            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;
            }
            return true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.UPDATE_GRADES(:P_DIEMQT,:P_DIEMTH,:P_DIEMCK,:P_DIEMTK,:P_MAHP, :P_MASV, :P_HK, :P_NAM, :P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_DIEMQT", textBox_qt.Text));
            command.Parameters.Add(new OracleParameter("P_DIEMTH", textBox_th.Text));
            command.Parameters.Add(new OracleParameter("P_DIEMCK", textBox_ck.Text));
            command.Parameters.Add(new OracleParameter("P_DIEMTK", textBox_tk.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_mahp.Text));
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_masv.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_namhoc.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));

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
            display_table_DS_SINHVIEN();
        }
    }
}
