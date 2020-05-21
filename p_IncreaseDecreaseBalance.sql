use emisora_laflauta;
drop procedure if exists p_IncreaseDecreaseBalance;
set sql_safe_updates = 0;
delimiter $$
create procedure p_IncreaseDecreaseBalance(in amount decimal(6,2),in id1 char(4),in id2 char(4),in id3 char(4),in id4 char(4))
begin
    declare v_id char(4);
    declare numberChildren int;
    declare saldo decimal(11,2);
    declare salaryMonth decimal(11,2);
    declare hecho int default 0;
    declare cur1 cursor for select p.idPFB,p.numberChilderPFB, sd.saldo, salaryMonthPFB from personal p inner join saldodisponible sd
    on p.idPFB = sd.id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = 1;
	open cur1;
	bucle: LOOP
    start transaction;
    FETCH cur1 INTO v_id,numberChildren,saldo, salaryMonth;
    if v_id = id1 then update saldodisponible set saldo = f_BalanceCalculation(amount, numberChildren, saldo, salaryMonth) where id = v_id;
    elseif v_id = id2 then update saldodisponible set saldo = f_BalanceCalculation(amount, numberChildren, saldo, salaryMonth) where id = v_id ;
    elseif v_id = id3 then update saldodisponible set saldo = f_BalanceCalculation(amount, numberChildren, saldo, salaryMonth) where id = v_id;
    elseif v_id = id4 then update saldodisponible set saldo = f_BalanceCalculation(amount, numberChildren, saldo, salaryMonth) where id = v_id;
    end if;
    
    if f_AvailableBalance(amount, saldo) then commit;
    else rollback;
    end if;
    
    IF hecho = 1 then 
		leave bucle;
    end if;
	END LOOP;
	
	CLOSE cur1;

end$$

delimiter ;
set sql_safe_updates = 0;

