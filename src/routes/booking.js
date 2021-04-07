const express = require("express");
const router = express.Router();
const bookingController = require("../app/controllers/BookingController");
const { route } = require("./authenticate");

router.get("/", bookingController.show);
router.get("/:id/edit", bookingController.edit);
router.delete("/:id/", bookingController.destroy);
// router.use('/search', siteController.search);

module.exports = router;