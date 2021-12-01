const std = @import("std");

pub fn printBanner(day: []const u8) !void {
   const stdout = std.io.getStdOut().writer();
   // ASCII Art from https://www.asciiart.eu/holiday-and-events/christmas/snowmen	
   const banner = 
\\========================================================================= 
\\=.      *    *           *.       *   .                      *     .    =  
\\=        |{s}|   .                   __   *    .     * .     *       =
\\=    *       *         *   .     .    _|__|_        *    __   .       * =     
\\=  .  *  /\       /\          *        ('')    *       _|__|_     .     = 
\\=       /  \   * /  \  *          .  <( . )> *  .       ('')   *   *    =  
\\=  *    /  \     /  \   .   *       _(__.__)_  _   ,--<(  . )>  .    .  =    
\\=      /    \   /    \          *   |       |  )),`   (   .  )     *    =  
\\=   *   `||` ..  `||`   . *.   ... ==========='`   ... '--`-` ... * jb .=      
\\=========================================================================
;
   try stdout.print(banner ++ "\n", .{day});
}
