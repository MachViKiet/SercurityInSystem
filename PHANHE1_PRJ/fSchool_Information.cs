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
    public partial class fSchool_Information : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fSchool_Information(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();

            display_table_SinhVien();
            display_table_KHMO();
            display_table_DonVi();
            display_table_HocPhan();

            bool init = display_table_SinhVien() && display_table_KHMO() && display_table_DonVi() &&  display_table_HocPhan();

            if (!init)
            {
                this.Close();
            }
        }

        private bool display_table_SinhVien()
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
                dataGridView_SinhVien.DataSource = dt;
                connect.Close();
                return true;
            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;

            }
        }

        private bool display_table_DonVi()
        {
            try
            {
                DataTable dt = new DataTable();
                if (connect.State != System.Data.ConnectionState.Open)
                {
                    connect.Open();
                }
                OracleDataAdapter adpt = new OracleDataAdapter("select * from QL_TRUONGHOC_X.DONVI_CHITIET", connect);
                adpt.Fill(dt);
                dataGridView_DonVi.DataSource = dt;
                connect.Close();
                return true;

            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;

            }
        }

        private bool display_table_HocPhan()
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
                dataGridView_HocPhan.DataSource = dt;
                connect.Close();
                return true;

            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;

            }
        }

        private bool display_table_KHMO()
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
                dataGridView_KHMO.DataSource = dt;
                connect.Close();
                return true;

            }
            catch (Exception ex)
            {
                connect.Close();
                MessageBox.Show(ex.Message);
                return false;

            }
        }

        private void dataGridView_SinhVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void fSchool_Information_Load(object sender, EventArgs e)
        {

        }
    }
}
