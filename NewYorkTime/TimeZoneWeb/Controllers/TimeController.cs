﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TimeZoneWeb.Controllers
{
    public class TimeController : Controller
    {
        // GET: Time
        public ActionResult Index()
        {
            return View();
        }
    }
}