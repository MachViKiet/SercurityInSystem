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
    public partial class fNhanSu : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fNhanSu(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            fPersonal_Information pi = new fPersonal_Information(connect);
            this.Hide();
            pi.ShowDialog();
            this.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            fSchool_Information si = new fSchool_Information(connect);
            this.Hide();
            si.ShowDialog();
            this.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            fTruongKhoa tk = new fTruongKhoa(connect);
            if (!tk.IsDisposed)
            {
                this.Hide();
                tk.ShowDialog();
                this.Show();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            fTruongDonVi tdv = new fTruongDonVi(connect);
            if (!tdv.IsDisposed)
            {
                this.Hide();
                tdv.ShowDialog();
                this.Show();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            fGiaoVu giaovu = new fGiaoVu(connect);
            if (!giaovu.IsDisposed)
            {
                this.Hide();
                giaovu.ShowDialog();
                this.Show();
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            fGiangVien gv = new fGiangVien(connect);
            if (!gv.IsDisposed)
            {
                this.Hide();
                gv.ShowDialog();
                this.Show();
            }
        }
    }
}
