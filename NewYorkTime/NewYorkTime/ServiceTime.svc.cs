using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace NewYorkTime
{
    public class ServiceTime : IServiceTime
    {
        public DateTime NewYorkTime()
        {
            return DateTime.Now.AddHours(-6);
        }

        public DateTime SanFranciscoTime()
        {
            return DateTime.Now.AddHours(-8);
        }

        public DateTime KoreaTime()
        {
            return DateTime.Now.AddHours(+9);
        }
    }
}
