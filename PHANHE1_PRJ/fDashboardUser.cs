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
    public partial class fDashboardUser : Form
    {
        private OracleConnection connect; // field

        public OracleConnection Connect   // property
        {
            get { return connect; }   // get method
            set { connect = value; }  // set method
        }
        public fDashboardUser(OracleConnection conn)
        {
            connect = conn;
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            fNhanSu nhansu = new fNhanSu(connect);
            this.Hide();
            nhansu.ShowDialog();
            this.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            fStudent nhansu = new fStudent(connect);
  
            if (!nhansu.IsDisposed)
            {
                this.Hide();
                nhansu.ShowDialog();
                this.Show();
            }
        }

        private void fDashboardUser_Load(object sender, EventArgs e)
        {

        }
    }
}
