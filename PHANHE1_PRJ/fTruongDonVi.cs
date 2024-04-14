using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Oracle.ManagedDataAccess.Client;
namespace PHANHE1_PRJ
{
    public partial class fTruongDonVi : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fTruongDonVi(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
            bool init = display_table_DS_PHANCONG() ?
                (display_table_DS_NHANSU_QUANLY() ?
                    (display_table_DS_HOCPHAN() ? true : false) : false) : false;
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
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.PHANCONG_TRUONGDONVI", connect);
                adpt.Fill(dt);
                dataGridView_PhanCong.DataSource = dt;
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

        private bool display_table_DS_NHANSU_QUANLY()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.TRUONGDONVI_NHANSU", connect);
                adpt.Fill(dt);
                dataGridView_NhanSu.DataSource = dt;
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

        private bool display_table_DS_HOCPHAN()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.KHMO_CHITIET", connect);
                adpt.Fill(dt);
                dataGridView_HocPhan.DataSource = dt;
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


        private void button_delete_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.DELETE_PHANCONG(:P_MANV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_manv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_mahp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_mact.Text));
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
            display_table_DS_PHANCONG();
        }

        private void button_update_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.UPDATE_PHANCONG(:P_MANV,:P_MAHP,:P_HK,:P_NAM,:P_CT,:P_NEW_MANV);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_manv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_mahp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_mact.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox1.Text));

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
            display_table_DS_PHANCONG();
        }

        private void button_add_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.ADD_PHANCONG(:P_MANV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_manv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_mahp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_mact.Text));

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
            display_table_DS_PHANCONG();
        }
    }
}
