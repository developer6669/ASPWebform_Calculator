using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASPWebform_Calculator
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod] // POST
        public static string Join(string Str,string Result)
        {
            return Result + Str;
        }

        [WebMethod] // POST
        public static string Calculate(string Operation,string Result)
        {
            switch (Operation)
            {
                case "+":
                    {
                        int sum = 0;
                        var numbers = Result.Split('+').Select(Int32.Parse).ToList();
                        Result = "";
                        foreach (var s in numbers)
                        {
                            sum = sum + s;
                        }
                        Result = Result + sum;
                    }
                    break;
                case "-":
                    {
                        var numbers = Result.Split('-').Select(Int32.Parse).ToList();
                        Result = "";
                        int sub = numbers[0] - numbers[1];

                        Result = Result + sub;
                    }
                    break;
                case "*":
                    {
                        int sub = 1;
                        var numbers = Result.Split('*').Select(Int32.Parse).ToList();
                        Result = "";
                        foreach (var s in numbers)
                        {
                            sub = sub * s;
                        }
                        Result = Result + sub;
                    }
                    break;
                case "/":
                    {
                        var numbers = Result.Split('/').Select(float.Parse).ToList();
                        Result = "";
                        float res = numbers[0] / numbers[1];
                        Result = Result + res;
                    }
                    break;
            }

            return Result;
        }
    }
}
