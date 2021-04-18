const { service, time } = require("../../config/db");

class ServiceController {
    //* [GET]/
    show(req, res, next) {
        (async() => {
            let result = await service.show();
            if (process.env.status != 0) {
                res.render("services/showServices", {
                    service: result,
                    status: process.env.status,
                    username: process.env.username,
                });
            } else {
                res.render("services/showServices", {
                    service: result,
                });
            }
        })();
    }
    add(req, res, next) {
        (async() => {
            if (process.env.status != 0) {
                res.render("services/addService", {
                    status: process.env.status,
                    username: process.env.username,
                });
            } else {
                res.redirect("/services");
            }
        })();
    }
    adding(req, res, next) {
        (async() => {
            if (process.env.status != 0) {
                await service.add(
                    req.body.name,
                    req.body.price,
                    req.body.describe,
                    req.body.img
                );
                res.redirect("/service");
            } else {
                res.redirect("/");
            }
        })();
    }
    edit(req, res, next) {
        (async() => {
            let result = await service.show(req.params.id);
            let timePeriod = await time.show();
            console.log(timePeriod);
            res.render("service/updateService", {
                service: result,
                timePeriod: timePeriod,
                status: process.env.status,
                username: process.env.username,
            });
        })();
    }
    destroy(req, res, next) {
        (async() => {
            let result = await service.destroy("DICHVU", req.params.id);
        })();
        res.redirect("/service");
    }
}

module.exports = new ServiceController();