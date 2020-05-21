
use emisora_laflauta;
delimiter $$

drop function if exists f_BalanceCalculation $$

create function f_BalanceCalculation(amount decimal(6,2), numberofchildren int, presentsaldo decimal(11,2), presentmonthsalary decimal(6,2))
returns decimal(11,2)
deterministic
begin
	if numberofchildren > 1 and presentmonthsalary < 3000 then return (amount * 0.05)+amount+presentsaldo;
    elseif numberofchildren <=1 or presentmonthsalary >= 3000 then return amount + presentsaldo;
	end if;
end$$

delimiter ;