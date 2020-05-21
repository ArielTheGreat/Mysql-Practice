
use emisora_laflauta;
delimiter $$

drop function if exists f_AvailableBalance $$

create function f_AvailableBalance(amount decimal(6,2), saldo decimal(11,2))
returns boolean
deterministic
begin
	if amount > 0 or amount + saldo > 100 then return true;
    elseif amount < 0 and saldo + amount <= 100 then return false;
    end if;
end$$

delimiter ;