using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.Common
{
    public static class LogHelper
    {
        public static void Error(Type type, object message, Exception exception = null)
        {
            ILog log = LogManager.GetLogger(type);
            if (exception == null)
                log.Error(message);
            else
                log.Error(message, exception);
        }

        public static void Info(Type type, object message, Exception exception = null)
        {
            ILog log = LogManager.GetLogger(type);
            if (exception == null)
                log.Info(message);
            else
                log.Info(message, exception);
        }
    }
}
