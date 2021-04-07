const authenticateRouter = require("./authenticate");
const productRouter = require("./product");
const bookingRouter = require("./booking");
const serviceRouter = require("./service");
const employeeRouter = require("./employee");
const productTypeRouter = require("./productType");
const customerRouter = require("./customer");
const accountRouter = require("./account");

function route(app) {
    // about status : 0 <=> not login , 1 <=> login with customer , 2 <=> login with staff , 3 <=> login with admin
    // Route Login
    app.use("/authenticate", authenticateRouter);
    // Route User
    app.get("/usr=:slug", (req, res) => {
        console.log("Hi");
        res.render("home", {
            name: req.params.slug,
        });
    });
    // Route Admin
    app.use("/admin/products",productRouter);
    // Route About
    app.use("/about", (req, res) => {
        res.render("about");
    });
    // Route booking
    app.use("/booking", bookingRouter);
    // Route Product
    app.use("/products", productRouter);
    // Route productType
    app.use("/productType", productTypeRouter);
    // Route Service
    app.use("/service", serviceRouter);
    // Route Customer
    app.use("/customer", customerRouter);
    // Route Account
    app.use("/account", accountRouter);
    // Route employee
    app.use("/employee", employeeRouter);
    // Route Home
    app.use("/", (req, res) => {
        if (process.env.status != 0) {
            res.render("home", {
                status: process.env.status,
                username: process.env.username,
            });
        } else {
            res.render("home");
        }
    });
}

module.exports = route;