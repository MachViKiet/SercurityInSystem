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
    public partial class fTruongKhoa : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fTruongKhoa(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
            bool init = display_table_DS_PHANCONG()
                && display_table_DS_DANGKY()
                && display_table_DS_NHANSU()
            && display_table_DS_NHANSU_2()
            && load_Data_dataGridView_hocphan()
            && load_Data_dataGridView_phancong();
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
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.PHANCONG_CHITIET", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool display_table_DS_DANGKY()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.DANGKY", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool display_table_DS_NHANSU()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.NHANSU", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool display_table_DS_NHANSU_2()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.NHANSU", connect);
                adpt.Fill(dt);
                dataGridView_NHANSU.DataSource = dt;
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
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.SINHVIEN", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool display_table_DS_KHMO()
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
                dataGridView1.DataSource = dt;
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
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.HOCPHAN", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool display_table_DS_DONVI()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.DONVI_CHITIET", connect);
                adpt.Fill(dt);
                dataGridView1.DataSource = dt;
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

        private bool load_Data_dataGridView_phancong()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.PHANCONG_CHITIET", connect);
                adpt.Fill(dt);
                dataGridView_phancong.DataSource = dt;
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

        private bool load_Data_dataGridView_hocphan()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.PHANCONG_CHITIET_VPK", connect);
                adpt.Fill(dt);
                dataGridView_hocphan.DataSource = dt;
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
            display_table_DS_NHANSU();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            display_table_DS_SINHVIEN();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            display_table_DS_DONVI();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            display_table_DS_HOCPHAN();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            display_table_DS_KHMO();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            display_table_DS_DANGKY();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            display_table_DS_PHANCONG();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_INSERT_PHANCONG(:P_MAGV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv_1.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp_1.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk_1.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_namhoc_1.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct_1.Text));
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

        private void button9_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_DELETE_PHANCONG( :p_MAHP,:p_MAGV,:p_NAM,:p_HK,:p_MACT );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("p_MAHP", textBox_hp_1.Text));
            command.Parameters.Add(new OracleParameter("p_MAHP", textBox_gv_1.Text));
            command.Parameters.Add(new OracleParameter("p_MAHP", textBox_namhoc_1.Text));
            command.Parameters.Add(new OracleParameter("p_MAHP", textBox_hk_1.Text));
            command.Parameters.Add(new OracleParameter("p_MAHP", textBox_ct_1.Text));

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
                load_Data_dataGridView_hocphan();
                load_Data_dataGridView_phancong();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_UPDATE_PHANCONG(:P_MAGV,:P_MAHP,:P_HK,:P_NAM,:P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv_1.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp_1.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk_1.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_namhoc_1.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct_1.Text));
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

        private void button13_Click(object sender, EventArgs e)
        {
            fSchool_Information si = new fSchool_Information(connect);
            si.Show();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_INSERT_NHANSU(:P_MANV,:P_HOTEN,:P_PHAI,:P_NGAYSINH,:P_PHUCAP, :DT, :VAITRO, :MADV);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_nv_3.Text));
            command.Parameters.Add(new OracleParameter("P_HOTEN", textBox_hocten_3.Text));
            command.Parameters.Add(new OracleParameter("P_PHAI", 'Y'));
            command.Parameters.Add(new OracleParameter("P_NGAYSINH", textBox_ngaysinh_3.Text));
            command.Parameters.Add(new OracleParameter("P_PHUCAP", textBox_phucap_3.Text));
            command.Parameters.Add(new OracleParameter("DT", textBox_sdt_3.Text));
            command.Parameters.Add(new OracleParameter("VAITRO", textBox_vaitro_3.Text));
            command.Parameters.Add(new OracleParameter("MADV", textBox_dv_3.Text));
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
                display_table_DS_NHANSU_2();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button14_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_DELETE_NHANSU(:P_MANV);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_nv_3.Text));
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
                display_table_DS_NHANSU_2();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button11_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.TRUONGKHOA_UPDATE_NHANSU(:P_MANV,:P_HOTEN,:P_PHAI,:P_NGAYSINH,:P_PHUCAP, :DT, :VAITRO, :MADV);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MANV", textBox_nv_3.Text));
            command.Parameters.Add(new OracleParameter("P_HOTEN", textBox_hocten_3.Text));
            command.Parameters.Add(new OracleParameter("P_PHAI", 'Y'));
            command.Parameters.Add(new OracleParameter("P_NGAYSINH", textBox_ngaysinh_3.Text));
            command.Parameters.Add(new OracleParameter("P_PHUCAP", textBox_phucap_3.Text));
            command.Parameters.Add(new OracleParameter("DT", textBox_sdt_3.Text));
            command.Parameters.Add(new OracleParameter("VAITRO", textBox_vaitro_3.Text));
            command.Parameters.Add(new OracleParameter("MADV", textBox_dv_3.Text));
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
                display_table_DS_NHANSU_2();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
