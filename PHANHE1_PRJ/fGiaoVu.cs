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
    public partial class fGiaoVu : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fGiaoVu(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
            bool init = display_table_DS_PHANCONG() && display_table_DS_DANGKY();
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
                OracleDataAdapter adpt = new OracleDataAdapter("SELECT * FROM QL_TRUONGHOC_X.V_THONGTIN_PHANCONGGIANGDAY", connect);
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
                dataGridView_dangky.DataSource = dt;
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

        private void button3_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.UPDATE_PHANCONGGIANGDAY_GIAOVU(:P_MAGV, :P_MAHP, :P_HK, :P_NAM, :P_CT, :P_NEW_MAGV);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_old_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));
            command.Parameters.Add(new OracleParameter("P_NEW_MAGV", textBox_new_gv.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Update Success");
                display_table_DS_PHANCONG();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }


        private void button2_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.DELETE_PHANCONG_GIAOVU(:P_MAGV, :P_MAHP, :P_HK, :P_NAM, :P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_old_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Delete Success");
                display_table_DS_PHANCONG();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.ADD_PHANCONG_GIAOVU(:P_MAGV, :P_MAHP, :P_HK, :P_NAM, :P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_old_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hp.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hk.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nam.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_ct.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("ADD Success");
                display_table_DS_PHANCONG();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button14_Click(object sender, EventArgs e)
        {
            fSchool_Information si = new fSchool_Information(connect);

            si.ShowDialog();
        }

        private void button14_Click_1(object sender, EventArgs e)  // Thông tin 
        {
            fSchool_Information si = new fSchool_Information(connect);
            si.Show();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            fSchool_Information si = new fSchool_Information(connect);
            si.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.DANGKY_MONHOC(:P_MASV, :P_MAGV, :P_MAHP, :P_HK, :P_NAM, :P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv.Text));
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hocphan.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hocky.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nh.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_mact.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Đăng Ký Môn Học Thành Công");
                display_table_DS_DANGKY();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.HUY_DANGKY_MONHOC(:P_MASV, :P_MAGV, :P_MAHP, :P_HK, :P_NAM, :P_CT);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv.Text));
            command.Parameters.Add(new OracleParameter("P_MAGV", textBox_gv.Text));
            command.Parameters.Add(new OracleParameter("P_MAHP", textBox_hocphan.Text));
            command.Parameters.Add(new OracleParameter("P_HK", textBox_hocky.Text));
            command.Parameters.Add(new OracleParameter("P_NAM", textBox_nh.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_mact.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Huỷ Đăng Ký Môn Học Thành Công");
                display_table_DS_DANGKY();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.THEM_DONVI( :P_MADV ,:P_TENDV );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MADV", textBox_dv_4.Text));
            command.Parameters.Add(new OracleParameter("P_TENDV", textBox_tendv_4.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Thêm Đơn Vị Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button11_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.THEM_SINHVIEN(:P_MASV, :P_HOCTEN, 'Y', :P_NS, :P_DIACHI, :P_DT , :P_CT , :P_MANGANH );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv_3.Text));
            command.Parameters.Add(new OracleParameter("P_HOCTEN", textBox_hoten_3.Text));
            command.Parameters.Add(new OracleParameter("P_NS", textBox_ns_3.Text));
            command.Parameters.Add(new OracleParameter("P_DIACHI", textBox_diachi_3.Text));
            command.Parameters.Add(new OracleParameter("P_DT", textBox_dt_3.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_CT_3.Text));
            command.Parameters.Add(new OracleParameter("P_MANGANH", textBox_manganh_3.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Thêm Sinh Viên Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.CAPNHAT_SINHVIEN(:P_MASV, :P_HOCTEN, 'Y', :P_NS, :P_DIACHI, :P_DT , :P_CT , :P_MANGANH );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MASV", textBox_sv_3.Text));
            command.Parameters.Add(new OracleParameter("P_HOCTEN", textBox_hoten_3.Text));
            command.Parameters.Add(new OracleParameter("P_NS", textBox_ns_3.Text));
            command.Parameters.Add(new OracleParameter("P_DIACHI", textBox_diachi_3.Text));
            command.Parameters.Add(new OracleParameter("P_DT", textBox_dt_3.Text));
            command.Parameters.Add(new OracleParameter("P_CT", textBox_CT_3.Text));
            command.Parameters.Add(new OracleParameter("P_MANGANH", textBox_manganh_3.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Cập Nhật Sinh Viên  Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.CAPNHAT_DONVI( :P_MADV ,:P_TENDV );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_MADV", textBox_dv_4.Text));
            command.Parameters.Add(new OracleParameter("P_TENDV", textBox_tendv_4.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Thêm Đơn Vị Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button13_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.THEM_HOCPHAN( :MAHP, :TENHP, :SOTC, :STLT, :STTH, :SOSVTD, :MADV );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("MAHP", textBox_hp_5.Text));
            command.Parameters.Add(new OracleParameter("TENHP", textBox_Tenhp_5.Text));
            command.Parameters.Add(new OracleParameter("SOTC", textBox_sotc_5.Text));
            command.Parameters.Add(new OracleParameter("STLT", textBox_solt_5.Text));
            command.Parameters.Add(new OracleParameter("STTH", textBox_soth_5.Text));
            command.Parameters.Add(new OracleParameter("SOSVTD", textBox_sl_5.Text));
            command.Parameters.Add(new OracleParameter("MADV", textBox_madv_5.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Thêm Học Phần Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.CAPNHAT_HOCPHAN( :MAHP, :TENHP, :SOTC, :STLT, :STTH, :SOSVTD, :MADV );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("MAHP", textBox_hp_5.Text));
            command.Parameters.Add(new OracleParameter("TENHP", textBox_Tenhp_5.Text));
            command.Parameters.Add(new OracleParameter("SOTC", textBox_sotc_5.Text));
            command.Parameters.Add(new OracleParameter("STLT", textBox_solt_5.Text));
            command.Parameters.Add(new OracleParameter("STTH", textBox_soth_5.Text));
            command.Parameters.Add(new OracleParameter("SOSVTD", textBox_sl_5.Text));
            command.Parameters.Add(new OracleParameter("MADV", textBox_madv_5.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Cập Nhật Học Phần Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.THEM_KHMO( :MAHP, :HK, :NAM, :MACT );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("MAHP", textBox_hp_5.Text));
            command.Parameters.Add(new OracleParameter("HK", textBox_Tenhp_5.Text));
            command.Parameters.Add(new OracleParameter("NAM", textBox_sotc_5.Text));
            command.Parameters.Add(new OracleParameter("MACT", textBox_solt_5.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Cập Nhật KHMO Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.CAPNHAT_KHMO( :MAHP, :HK, :NAM, :MACT );\nEND;", connect);
            command.Parameters.Add(new OracleParameter("MAHP", textBox_hp_5.Text));
            command.Parameters.Add(new OracleParameter("HK", textBox_Tenhp_5.Text));
            command.Parameters.Add(new OracleParameter("NAM", textBox_sotc_5.Text));
            command.Parameters.Add(new OracleParameter("MACT", textBox_solt_5.Text));

            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                connect.Close();

                MessageBox.Show("Cập Nhật KHMO Thành Công");

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
