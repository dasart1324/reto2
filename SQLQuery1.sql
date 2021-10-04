create database Reto2
go

use Reto2
go

create table libros(
   codigo varchar(5),
   titulo varchar(40),
   autor varchar(30),
   editorial varchar(20),
   precio decimal(5,2),
   cantidad smallint,
   primary key(codigo)
  )  

  create proc sp_listar_libros
  as
  select * from libros order by codigo
  go

  create proc sp_buscar_libros
  @codigo varchar(5)
  as
  select codigo, titulo, autor, editorial, precio, cantidad from libros where codigo = @codigo
  go

  create proc sp_mantenimiento_libros
   @codigo varchar(5),
   @titulo varchar(40),
   @autor varchar(30),
   @editorial varchar(20),
   @precio int,
   @cantidad smallint,
   @accion varchar(50) output
   as
   if(@accion = '1')
   begin
	declare @codnuevo varchar(5), @codmax varchar(5)
	set @codmax = (select MAX(codigo) from libros)
	set @codmax = ISNULL(@codmax, '0000')
	set @codnuevo = RIGHT(RIGHT(@CODMAX,4)+10001,4)
	insert into libros(codigo,titulo,autor,editorial,precio,cantidad)
	values(@codnuevo,@titulo,@autor,@editorial,@precio,@cantidad)
	set @accion = 'Se genero el código: ' + @codnuevo
	end
	else if (@accion = '2')
	begin
		update libros set titulo = @titulo, autor = @autor, editorial = @editorial, precio = @precio, cantidad = @cantidad where codigo = @codigo
		set @accion = 'Se modifico el código: ' + @codigo
	end
	else if (@accion = '3')
	begin
	delete from libros where codigo = @codigo
	set @accion = 'Se ha eliminado el código: ' + @codigo
	end
	go