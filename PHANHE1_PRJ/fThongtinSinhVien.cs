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
    public partial class fThongtinSinhVien : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fThongtinSinhVien(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();

            bool init = loadData();
            if (!init)
            {
                this.Close();
            }
        }

        private bool loadData()
        {
            string query = "select * from QL_TRUONGHOC_X.SINHVIEN";
            OracleCommand command = new OracleCommand(query, connect);
            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                // In tên các cột

                // In dữ liệu
                reader.Read();
                label_masv.Text = reader[0].ToString();
                label_hoten.Text = reader[1].ToString();
                // Đọc giới tính
                label_phai.Text = reader[2].ToString();
                label_ngaysinh.Text = reader[3].ToString();
                textBox_diachi.Text = reader[4].ToString();
                textBox_dt.Text = reader[5].ToString();
                label_ct.Text = reader[6].ToString();
                label_manganh.Text = reader[7].ToString();
                label_tbtl.Text = reader[8].ToString();
                label_diemtong.Text = reader[9].ToString();


                Console.WriteLine();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                return false;
            }
        }


        private void button1_Click(object sender, EventArgs e)
        {
            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.UPDATE_INF_STUDENT(:P_NEWPHONE,:P_NEWADDRESS);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_NEWADDRESS", textBox_diachi.Text));
            command.Parameters.Add(new OracleParameter("P_NEWPHONE", textBox_dt.Text));
            try
            {
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataReader reader = command.ExecuteReader();

                command.ExecuteNonQuery();

                connect.Close();

                MessageBox.Show("Update Success");

                loadData();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        private void label18_Click(object sender, EventArgs e)
        {

        }
    }
}
