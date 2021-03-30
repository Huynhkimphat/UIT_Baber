const { showBooking, addBooking } = require("../../config/db");
class bookingController {
    //* [GET]/
    show(req, res, next) {
        (async() => {
            let result = await showBooking("DATLICH", 0);
            res.render('booking/showBooking', {
                booking: result.rows,
            });
        })();
    }
    AddBooking(req, res, next) {
        res.render('booking/addBooking');
    }
    Adding(req, res, next) {
        (async() => {
            let result = await addBooking(req.body.date);

        })();
        res.redirect('/booking');
    }

}

module.exports = new bookingController();