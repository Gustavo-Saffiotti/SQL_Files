#Aqueles usuários cujo nome comece com a letra ‘J’.
select *
from `system_user`
where first_name like 'J%'

#Aqueles usuários cujo sobrenome contenha a letra ‘W’.
select *
from `system_user`
where last_name like '%w%'

#Aqueles usuários cujo nome contenha a letra ‘i’ na segunda posição.
select *
from `system_user`
where first_name like '_i%'

#Aqueles usuários cujo nome termine com a letra ‘k’.
select *
from `system_user`
where first_name like '%k'

#Aqueles usuários cujo nome não inclua as letras ‘ch’.
select *
from `system_user`
where first_name not like '%ch%'

#Aqueles usuários cujo nome inclua somente as letras ‘ch’.
select *
from `system_user`
where first_name like '%ch%'
