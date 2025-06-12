{ users, ... }:
{
	imports =
		(builtins.map (username: { name = username; value = ./${username}; }) users);
}
