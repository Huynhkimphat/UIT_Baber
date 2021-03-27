const authenticateRouter = require("./authenticate");
const productRouter = require("./product");
<<<<<<< HEAD
const bookingRouter = require("./booking");
=======
const serviceRouter = require("./service");
>>>>>>> master

function route(app) {
    // Route Login
    app.use("/authenticate", authenticateRouter);
    // Route User
    app.get("/usr=:slug", (req, res) => {
        console.log("Hi");
        res.render("home", {
            name: req.params.slug,
        });
    });
    // Route About
    app.use("/about", (req, res) => {
        res.render("about");
    });
    // Route booking
    app.use("/booking", bookingRouter);
    // Route Product
    app.use("/products", productRouter);
    // Route Service
    app.use("/service", serviceRouter);

    // Route Home
    app.use("/", (req, res) => {
        res.render("home", {
            login: "Login",
            register: "Register",
        });
    });
}

module.exports = route;