# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  3.0.6
* Rails version
  Rails 7.0.8
* System dependencies
  - Postgresql

* Configuration
- En el archivo `config/database.yml` en el key `development` asigna los siguientes dos atributos de tu usuario de base de datos: `#username:, #password:`
- Si tu usuario de `postgres` por defecto tiene permisos de creación podrías omitir el paso anterior
* Database creation
  - Crea la base de datos con `rails db:create`
  - Crea el modelo de datos con `rails db:migrate`
  - asegurate de correr `bundle` para instalar las gemas y rails antes de los pasos anteriores
* Database initialization
  - Poblala con registros dummy haciendo `rails db:seed`
* How to run the test suite
  - Corre la suite de pruebas completa con `rails t test/*`

* Diagrama de flujo para sincronizar repo
https://drive.google.com/file/d/10ZLmxLuehifHiVXxD9c_dC1B7Tb_ORSa/view?usp=drive_link

* Diagrama de componentes
https://drive.google.com/file/d/157pB-rMuvjs5lNQTWLXdv_7btmRYD5Ro/view?usp=drive_link

