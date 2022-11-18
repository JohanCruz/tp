function index(req, res) {
  req.getConnection((err, conn) => {
    let sql = 'CALL getCompetitors()';
    // conn.query('SELECT * FROM competitor', (err, competitor) => {
    conn.query(sql, (err, competitor) => {
      if(err) {
        res.json(err);
      }
      
      //let r = JSON.parse(JSON.stringify(competitor));
      //let competitors = r[0];

      console.log('competitors', competitor[0])
      let competitors = competitor[0];
      res.render('competitor/index', { competitors });
    });

       
  });
}

function create(req, res) {

  res.render('competitor/create');
}

function store(req, res) {
  const data = req.body;

  req.getConnection((err, conn) => {
    conn.query('INSERT INTO competitor SET ?', [data], (err, rows) => {
      res.redirect('/competitor');
    });
  });
}

function destroy(req, res) {
  const id = req.body.id;

  req.getConnection((err, conn) => {
    conn.query('DELETE FROM competitor WHERE id = ?', [id], (err, rows) => {
      res.redirect('/competitor');
    });
  })
}

function edit(req, res) {
  const id = req.params.id;

  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM competitor WHERE id = ?', [id], (err, competitor) => {
      if(err) {
        res.json(err);
      }
      res.render('competitor/edit', { competitor });
    });
  });
}

function update(req, res) {
  const id = req.params.id;
  const data = req.body;

  req.getConnection((err, conn) => {
    conn.query('UPDATE competitor SET ? WHERE id = ?', [data, id], (err, rows) => {
      res.redirect('/competitor');
    });
  });
}


module.exports = {
  index: index,
  create: create,
  store: store,
  destroy: destroy,
  edit: edit,
  update: update,
}