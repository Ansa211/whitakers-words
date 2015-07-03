-- WORDS, a Latin dictionary, by Colonel William Whitaker (USAF, Retired)
--
-- Copyright William A. Whitaker (1936–2010)
--
-- This is a free program, which means it is proper to copy it and pass
-- it on to your friends. Consider it a developmental item for which
-- there is no charge. However, just for form, it is Copyrighted
-- (c). Permission is hereby freely given for any and all use of program
-- and data. You can sell it as your own, but at least tell me.
--
-- This version is distributed without obligation, but the developer
-- would appreciate comments and suggestions.
--
-- All parts of the WORDS system, source code and data files, are made freely
-- available to anyone who wishes to use them, for whatever purpose.

with Text_IO; use Text_IO;
with inflections_package; use inflections_package;
with dictionary_package; use dictionary_package;
with addons_package; use addons_package;
with uniques_package; use uniques_package;
package line_stuff is
   pragma Elaborate_Body;

   type dictionary_item;
   type dictionary_list is access dictionary_item;
   type dictionary_item is
      record
         de   : dictionary_entry := null_dictionary_entry;
         succ : dictionary_list;
      end record;

   type dictionary is array (Character) of dictionary_list;
   null_dictionary : dictionary := (others => null);
   --DICT, UNIQUES, QUES : DICTIONARY := NULL_DICTIONARY;
   dict, uniques : dictionary := null_dictionary;

   dict_loc : dictionary := null_dictionary;

   type tackon_line is
      record
         pofs : part_of_speech_type := tackon;
         tack : stem_type := null_stem_type;
         entr : tackon_entry := null_tackon_entry;
         mean : meaning_type := null_meaning_type;
      end record;

   null_tackon_line : tackon_line;

   package tackon_line_io is
      Default_Width : Natural;
      procedure Get(f : in File_Type; p : out tackon_line);
      procedure Get(p : out tackon_line);
      procedure Put(f : in File_Type; p : in tackon_line);
      procedure Put(p : in tackon_line);
      procedure Get(s : in String; p : out tackon_line; last : out Integer);
      procedure Put(s : out String; p : in tackon_line);
   end tackon_line_io;

   type prefix_line is
      record
         pofs : part_of_speech_type := prefix;
         fix  : fix_type := null_fix_type;
         connect : Character := ' ';
         entr : prefix_entry := null_prefix_entry;
         mean : meaning_type := null_meaning_type;
      end record;

   null_prefix_line : prefix_line;

   package prefix_line_io is
      Default_Width : Natural;
      procedure Get(f : in File_Type; p : out prefix_line);
      procedure Get(p : out prefix_line);
      procedure Put(f : in File_Type; p : in prefix_line);
      procedure Put(p : in prefix_line);
      procedure Get(s : in String; p : out prefix_line; last : out Integer);
      procedure Put(s : out String; p : in prefix_line);
   end prefix_line_io;

   type suffix_line is
      record
         pofs : part_of_speech_type := suffix;
         fix  : fix_type := null_fix_type;
         connect    : Character := ' ';
         entr : suffix_entry := null_suffix_entry;
         mean : meaning_type := null_meaning_type;
      end record;

   null_suffix_line : suffix_line;

   package suffix_line_io is
      Default_Width : Natural;
      procedure Get(f : in File_Type; p : out suffix_line);
      procedure Get(p : out suffix_line);
      procedure Put(f : in File_Type; p : in suffix_line);
      procedure Put(p : in suffix_line);
      procedure Get(s : in String; p : out suffix_line; last : out Integer);
      procedure Put(s : out String; p : in suffix_line);
   end suffix_line_io;

   type unique_entry is
      record
         stem : stem_type          := null_stem_type;
         qual : quality_record     := null_quality_record;
         kind : kind_entry         := null_kind_entry;
         tran : translation_record := null_translation_record;
      end record;

   package unique_entry_io is
      Default_Width : Field;
      procedure Get(f : in File_Type; p : out unique_entry);
      procedure Get(p : out unique_entry);
      procedure Put(f : in File_Type; p : in unique_entry);
      procedure Put(p : in unique_entry);
      procedure Get(s : in String; p : out unique_entry; last : out Integer);
      procedure Put(s : out String; p : in unique_entry);
   end unique_entry_io;

   procedure load_stem_file(d_k : dictionary_kind);

   procedure load_dictionary(dict : in out dictionary;
                             dictionary_file_name : String);

   procedure load_uniques(unq : in out latin_uniques; file_name : in String);

end line_stuff;
