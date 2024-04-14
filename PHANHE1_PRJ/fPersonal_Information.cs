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
    public partial class fPersonal_Information : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fPersonal_Information(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
            loadData();
        }

        private void loadData()
        {
            string query = "select * from QL_TRUONGHOC_X.V_PERSONAL_INF_NHANSU";
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
                lb_ma.Text = reader[0].ToString();
                lb_name.Text = reader[1].ToString();
                // Đọc giới tính
                lb_date.Text = reader[3].ToString();
                lb_phucap.Text = reader[4].ToString();
                lb_sdt.Text = reader[5].ToString();
                lb_role.Text = reader[6].ToString();
                lb_donvi.Text = reader[7].ToString();

                Console.WriteLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }


        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void fPersonal_Information_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

            OracleCommand command = new OracleCommand("BEGIN\nQL_TRUONGHOC_X.UPDATE_PHONE(:P_NEWPHONE);\nEND;", connect);
            command.Parameters.Add(new OracleParameter("P_NEWPHONE", textBox1.Text));
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
    }
}
