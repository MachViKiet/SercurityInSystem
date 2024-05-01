namespace PHANHE1_PRJ
{
    partial class fDashboardUser
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
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.button_notification = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 11.1F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(7, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(410, 42);
            this.label1.TabIndex = 0;
            this.label1.Text = "Chọn Vai Trò Của Bạn : ";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(474, 99);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(333, 101);
            this.button1.TabIndex = 1;
            this.button1.Text = "Sinh Viên";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(116, 99);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(333, 101);
            this.button2.TabIndex = 2;
            this.button2.Text = "Nhân Sự";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.button3);
            this.panel1.Controls.Add(this.button_notification);
            this.panel1.Controls.Add(this.button2);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(5, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(897, 494);
            this.panel1.TabIndex = 3;
            // 
            // button_notification
            // 
            this.button_notification.Location = new System.Drawing.Point(286, 229);
            this.button_notification.Name = "button_notification";
            this.button_notification.Size = new System.Drawing.Size(333, 101);
            this.button_notification.TabIndex = 3;
            this.button_notification.Text = "Xem Thông Báo";
            this.button_notification.UseVisualStyleBackColor = true;
            this.button_notification.Click += new System.EventHandler(this.button3_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(286, 367);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(333, 101);
            this.button3.TabIndex = 4;
            this.button3.Text = "Xem Nhật Ký";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click_1);
            // 
            // fDashboardUser
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 31F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(946, 599);
            this.Controls.Add(this.panel1);
            this.Name = "fDashboardUser";
            this.Text = "Trang Chủ";
            this.Load += new System.EventHandler(this.fDashboardUser_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button button_notification;
        private System.Windows.Forms.Button button3;
    }
}