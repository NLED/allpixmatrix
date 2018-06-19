 MIT License
 
 Copyright (c) 2018 Northern Lights Electronic Design, LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 Original Author: Jeffrey Nygaard
 Copyright 2018
 Company: Northern Lights Electronic Design, LLC
 Contact: JNygaard@NLEDShop.com
 Date Updated: June 19, 2018 
 Software Version:  BETA 0.1
 Webpage: www.NLEDShop.com/nledallpixmatrix
 Written in Processing v3.3.7  - www.Processing.org
 
 THIS SOFTWARE IS IN BETA - PLEASE REPORT BUGS
 
 ======================================================================================================================================
 
What It Does:
The software uses many media types such as images, animated GIFs, videos(many codecs), Spout/Syphon, external data reception(like Glediator) and software
generated content. It converts or maintains the media to low resolution, that will display well on low resolution LED matrices. Small scale LED matrices
require low resolution media, as scaling down larger standard sized media results in poor looking images once down scaled. The different types of 
media content can be mixed together in different ways, and have effects and filters applied to them. The resulting output is transmitted out to a serial
port(like a FTDI or USB enabled microcontroller) which converts it to a pixel chipset protocol and sends it to the pixels.

Description:
This program was written for use with my projects and products, but hope it will be useful to others as well. I am frequently asked about how best to 
create content for low-resolution pixel matrices. There are a few choices out there, but none that are feature rich and open source. This software was 
kept simple as possible with the ability to easily modify and add to it. Processing has many inbuilt graphics functions that made it a good choice for 
this type of software.

Compatible Controllers: There are many ways to receive the output from this software.
NLED Pixel Controller Micro - Serial
NLED Pixel Controller Mini - Serial
NLED Pixel Controller Ion - Aurora USB or Serial
NLED Pixel Controller Electron - Aurora USB or Serial
More NLED Controllers will be available soon

Currently no Arduino library, but should work with any Gleidator compatible sketches. If someone wants to write one, I can link it.
Previously I have had reports that USB enabled Arduinos may not work with the default USB stack. I think this is because the default USB stack
can not handle the data volume. So the stack may need to be adjusted or rewritten.

Maximum Size matrix: 512x512 - not tested or know if it would actually work. But software would support it.