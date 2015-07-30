module ddemangle;

import std.stdio : writef, stdin, KeepTerminator;
import std.string : indexOf;
import std.demangle : demangle;

int main()
{
	foreach(line; stdin.byLine(KeepTerminator.yes)) {
		auto start = line.indexOf("_D");
		if (start < 0) {
			writef(line);
			continue;
		}
		auto end = line[start .. $].indexOf(" ");
		if (end < 0) {
			writef(line);
			continue;
		}

		end += start; // Account for start offset.

		writef("%s", line[0 .. start]);
		writef("\"");
		writef("%s", demangle(cast(string)line[start .. end]));
		writef("\"");
		writef("%s", line[end .. $]);
	}

	return 0;
}
