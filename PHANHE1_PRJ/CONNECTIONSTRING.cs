using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PHANHE1_PRJ
{
    internal class CONNECTIONSTRING
    {
        string PATH = "(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521)))(CONNECT_DATA = (SERVER = DEDICATED)(SERVICE_NAME = XE)))";
        static string conStr = "";

        public string getString()
        {
            return conStr;
        }

        public void setConStr(string username, string password)
        {
            conStr = "Data Source = " + PATH + "; User Id = " + username + ";password=" + password;
        }
    }
}
