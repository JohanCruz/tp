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
    console.log('data', data);
    console.log('data', data['id_employee']);

    conn.query('SELECT * FROM employee where id = ?',data['id_employee'], (err, employee) => {
      console.log('employee', employee)
      if (employee === undefined) {
        let message = 'no pudo guardar, id empleado no encontrado';
        res.render('competitor/create', { message });
      } else {
        let message = 'id empleado encontrado';
        if (employee[0]['id_position'] !== 1){
          message = 'no se pudo guardar, el cargo del empleado no es asesor';
          res.render('competitor/create', { message });
        } else {
          if(employee[0]['id_city'] > 2){
            message = 'Los empleados que participan trabajan en ciudades como Bogotá y Medellín';
            res.render('competitor/create', { message });
          } else {
            console.log('llega al final');
            let sql = 'SELECT * FROM competitor where id_employee = ? and id_contest = ?';
            conn.query(sql, [data['id_employee'], data['id_contest']], (err, competitor) => {
              if(err) {
                res.json(err); 
              }
              if(competitor[0] !== undefined){
                message = 'Ya se habia inscrito en ese concurso';
                let unableForm = true;
                console.log('competitor' , competitor);
                console.log('competitor[times]', competitor[0]['times']);
                let sql = 'UPDATE competitor SET times= ? where id_employee = ? and id_contest = ?';
                conn.query(sql, [competitor[0]['times'] + 1, Number(data['id_employee']), Number(data['id_contest'])], (err) =>{
                  if(err) {
                    res.json(err);
                  }
                });
                res.render('competitor/create', { message, unableForm });
              } else {
                message = 'se incribe correctamente';
                data['times'] = 1;
                conn.query('INSERT INTO competitor SET ?', [data], (err, rows) => {
                  if(err) {
                    // res.json(err);
                    message = 'Sucedió algun error inscribiendo al concurso';
                    res.render('competitor/create', { message });
                  } else {

                    res.render('competitor/create', { message });

                  }
                });

                
              }
              
            });
          }
        }
        
      }
    });

    // conn.query('INSERT INTO competitor SET ?', [data], (err, rows) => {
    //   res.redirect('/competitor');
    // });
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