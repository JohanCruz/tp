const express = require('express');
const CompetitorController = require('../controllers/CompetitorController');

const router = express.Router();

router.get('/competitor', CompetitorController.index);
router.get('/create', CompetitorController.create);
router.post('/create', CompetitorController.store);
router.post('/competitor/delete', CompetitorController.destroy);
router.get('/competitor/edit/:id', CompetitorController.edit);
router.post('/competitor/edit/:id', CompetitorController.update);

module.exports = router;