/*
 * Copyright (C) 2013 Ronny Yabar <ronnycontacto@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU Lesser General Public License,
 * version 2.1, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
 * more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 */

var server = "yourserver.com"
var urlBase = "http://xml." + server + "/"
var urlArtistsImage = "http://cdn." + server + "/artists/"
var artistsXML = urlBase + "artists.xml"
var artistDetailXml = urlBase + "artist-songs.xml?id="
var albumsXML = urlBase + "albums.xml"
var albumDetailXML = urlBase + "album-songs.xml?id="
var genresXml = urlBase + "genre.xml"
var genreDetailXML = urlBase + "genre-songs.xml?id="
var genreArtistsXML = urlBase + "genre-artists.xml?id="
var songsXML = urlBase + "songs.xml"
var searchXml = urlBase + "search.xml?q="
