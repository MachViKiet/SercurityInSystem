namespace PHANHE1_PRJ
{
    partial class fLogin
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.P_USERNAME = new System.Windows.Forms.TextBox();
            this.P_PASSWORD = new System.Windows.Forms.TextBox();
            this.bt_DANGNHAP = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 53);
            this.label2.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(220, 32);
            this.label2.TabIndex = 1;
            this.label2.Text = "Tên đăng nhập :";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 120);
            this.label3.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(145, 32);
            this.label3.TabIndex = 2;
            this.label3.Text = "Mật khẩu :";
            // 
            // P_USERNAME
            // 
            this.P_USERNAME.Location = new System.Drawing.Point(256, 53);
            this.P_USERNAME.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
            this.P_USERNAME.Name = "P_USERNAME";
            this.P_USERNAME.Size = new System.Drawing.Size(450, 38);
            this.P_USERNAME.TabIndex = 3;
            this.P_USERNAME.TextChanged += new System.EventHandler(this.P_USERNAME_TextChanged);
            // 
            // P_PASSWORD
            // 
            this.P_PASSWORD.Location = new System.Drawing.Point(256, 114);
            this.P_PASSWORD.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
            this.P_PASSWORD.Name = "P_PASSWORD";
            this.P_PASSWORD.Size = new System.Drawing.Size(450, 38);
            this.P_PASSWORD.TabIndex = 4;
            this.P_PASSWORD.UseSystemPasswordChar = true;
            // 
            // bt_DANGNHAP
            // 
            this.bt_DANGNHAP.Location = new System.Drawing.Point(256, 189);
            this.bt_DANGNHAP.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
            this.bt_DANGNHAP.Name = "bt_DANGNHAP";
            this.bt_DANGNHAP.Size = new System.Drawing.Size(244, 65);
            this.bt_DANGNHAP.TabIndex = 5;
            this.bt_DANGNHAP.Text = "Đăng nhập";
            this.bt_DANGNHAP.UseVisualStyleBackColor = true;
            this.bt_DANGNHAP.Click += new System.EventHandler(this.bt_DANGNHAP_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.bt_DANGNHAP);
            this.panel1.Controls.Add(this.P_PASSWORD);
            this.panel1.Controls.Add(this.P_USERNAME);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Location = new System.Drawing.Point(24, 13);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(736, 302);
            this.panel1.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 31F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(776, 329);
            this.Controls.Add(this.panel1);
            this.Margin = new System.Windows.Forms.Padding(5, 5, 5, 5);
            this.Name = "Form1";
            this.Text = "Đăng nhập";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox P_USERNAME;
        private System.Windows.Forms.TextBox P_PASSWORD;
        private System.Windows.Forms.Button bt_DANGNHAP;
        private System.Windows.Forms.Panel panel1;
    }
}

