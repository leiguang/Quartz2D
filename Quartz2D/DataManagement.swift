//
//  DataManagement.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/15.
//  Copyright © 2018年 leiguang. All rights reserved.
//


// [Data Management in Quartz 2D](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_data_mgr/dq_data_mgr.html#//apple_ref/doc/uid/TP30001066-CH216-TPXREF101)


/**
 对于Quartz，数据管理是指向Quartz 2D例程提供数据或从Quartz 2D例程接收数据。一些Quartz 2D例程将数据移入Quartz，例如从文件或应用程序的其他部分获取图像或PDF数据的数据。 其他例程接受Quartz数据，例如将图像或PDF数据写入文件或将数据提供给应用程序的另一部分。
 Managing data is a task every graphics application needs to perform. For Quartz, data management refers to supplying data to or receiving data from Quartz 2D routines. Some Quartz 2D routines move data into Quartz, such as those that get image or PDF data from a file or another part of your application. Other routines accept Quartz data, such as those that write image or PDF data to a file or provide the data to another part of your application.
 */


/**
 Mac OS X或iOS中的其他图形技术通常提供自己的例程来与Quartz进行通信。例如一个MacOS X应用程序能将Quartz中的图片送给Core Images处理，对图片做复杂的效果，再返回Quartz。
 Other graphics technologies in Mac OS X or iOS often provide their own routines to communicate with Quartz. For example, a Mac OS X application can send Quartz images to Core Image and use it to alter the image with sophisticated effects.
 */


/**
 CGImageSourceRef 和 CGDataProviderRef提供抽象了对数据的获取，并消除了通过原始内存缓冲区管理数据的需要。
 Image sources and data providers abstract the data-access task and eliminate the need for applications to manage data through a raw memory buffer.
 */


/**
 注意：在处理原始图像数据时为了获得最佳性能，请使用vImage框架。 您可以使用vImageBuffer_InitWithCGImage函数将图像数据从CGImageRef引用导入vImage。 有关详细信息，请参阅[Accelerate Release Notes](https://developer.apple.com/library/content/releasenotes/Performance/RN-vecLib/index.html#//apple_ref/doc/uid/TP40001049)。
 Note: For the best performance when working with raw image data, use the vImage framework. You can import image data to vImage from a CGImageRef reference with the vImageBuffer_InitWithCGImage function. For details, see Accelerate Release Notes.
 
 vImage是一个纯C语言写的，用于低级别图像处理操作的高性能框架。 这是Accelerate.framework的子框架。 当你链接了Accelerate库时，你就能使用vImage。 vImage提供诸如模糊，图像重采样/调整大小，边缘检测，直方图，alpha合成，颜色和图像格式转换等功能。
 vImage is a high-performance framework for low-level image processing operations. It is a subframework of Accelerate.framework. When you link to Accelerate, you get vImage. vImage provides capabilities such as blurring, image resampling/resizing, edge detection, histograms, alpha compositing, color, and image format conversions.
 
 一般来说，vImage比较省时间，但使用专用矢量处理器和数据高速缓存来处理图像会产生一定的成本。 例如，使用vImage来处理单张，平均大小的照片是不划算。 虽然vImage完全可以做这样的处理，但它的好处在于实时处理图像或连续重复操作。 如果您不处理大型高分辨率图像，Core Image是更好的选择。
 Generally speaking, vImage is a timesaver, but there are certain costs associated with using the specialized vector processor and data caches to process your images. For example, it would not be practical to use vImage to process a single, average-sized photo. While vImage is perfectly capable of doing such processing, its benefit lies in processing images in real-time or repeating an operation successively. Core Image is a better choice if you are not dealing with large, high-resolution images.
 
 (另参阅网上文章：Core Image 适合处理小量大图，而非常不适合处理大量小图。因为 CI 利用 GPU 运算，而数据到 GPU 的round-trip 时间数量级在 millisecond。这就意味着，1000 张小图分别再 GPU 运算，时间至少再 1000*1 ms。此文作者尝试绘制3000张小图片，利用 Cocoa Drawing 原本耗时 750ms，但是改用CI后耗时猛增到3秒。)(http://blog.csdn.net/liangliang103377/article/details/45696927)
 
 所以，这就是CI在osx绘制技术里所处的宏观角色：单图做实时处理。)
 
 [vImage Programming Guide](https://developer.apple.com/library/content/documentation/Performance/Conceptual/vImage/OverviewofvImage/OverviewofvImage.html#//apple_ref/doc/uid/TP30001001-CH202-SW1)
 */

