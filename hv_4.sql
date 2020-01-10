use vk

-- ii. �������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������

SELECT firstname FROM users  GROUP BY firstname;

-- iii. �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = true). ��� ������������� �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = false (��� 0)

alter TABLE profiles
ADD is_active CHAR(1) DEFAULT '0';

UPDATE profiles
SET 
	is_active  = '1'
WHERE
	DATEDIFF(current_date, birthday) > 6570 ; -- 18*365=6570
	
-- iv. �������� ������, ��������� ��������� ��� �������� (���� ����� �����������)

delete from messages
where current_date < created_at ;	