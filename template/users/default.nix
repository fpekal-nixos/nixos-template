{ users, ... }:
{
	imports =
		(builtins.map (username: ./${username}) users);
}
