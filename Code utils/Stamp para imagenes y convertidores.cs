        //Colocar una estampa a la imagen
        private async Task<string> StampJGP(string pathImage, string nombreSuplidor)
        {

            Image img = Image.FromFile(pathImage);
            //System.Drawing.Image imgOverlay = System.Drawing.Image.FromFile("overlay.png");
            Graphics gr = Graphics.FromImage(img);

            Font font1 = new Font("Arial Narrow", 12, FontStyle.Regular);
            Font font = new Font("Arial Narrow", 18, FontStyle.Regular);
            Color color = Color.FromArgb(255, 255, 255, 255);
            Color backgroundColor = Color.FromArgb(53, 118, 2, 130);

            StringFormat stringFormat = new StringFormat();
            stringFormat.Alignment = StringAlignment.Far;
            stringFormat.LineAlignment = StringAlignment.Far;
            nombreSuplidor = nombreSuplidor.Trim().Length >= 30 ? nombreSuplidor.Trim().Substring(0, 30) : nombreSuplidor.Trim();
            // Measure string.
            SizeF stringSize = new SizeF();
            stringSize = gr.MeasureString(nombreSuplidor, font1);

            int lengthSp = nombreSuplidor.Trim().Length;

            gr.SmoothingMode = SmoothingMode.AntiAlias;
            //gr.DrawImage(imgOverlay, new Point(img.Width - 78, img.Height - 25));
            Rectangle rect = new Rectangle(new Point(img.Width - ((int)stringSize.Width) - 6, img.Height - 55), new Size((int)stringSize.Width, 20));
            Rectangle rect2 = new Rectangle(new Point(img.Width - (230), img.Height - 30), new Size(220, 20));
            gr.FillRectangle(new SolidBrush(backgroundColor), rect);
            gr.DrawString(nombreSuplidor.ToUpper(), font1, new SolidBrush(color),
                new Point(img.Width - 5, img.Height - 35), stringFormat);
            gr.FillRectangle(new SolidBrush(backgroundColor), rect2);
            gr.DrawString(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"), font, new SolidBrush(color),
                new Point(img.Width - 5, img.Height - 5), stringFormat);

            MemoryStream outputStream = new MemoryStream();
            var filePath = @_webhostEnviroment.ContentRootPath + "\\ImgStamp.jpg";
            if ( File.Exists(filePath) )
            {
                System.GC.Collect();
                System.GC.WaitForPendingFinalizers();
                File.Delete(filePath);
            }
            img.Save("ImgStamp.jpg");

            return filePath;
        }
 //Convertir Array de bytes a imagen 
         private async Task<string> ConvertArrayBitesToImg(byte[] bytes)
        {
            var apiFilePath = @_webhostEnviroment.ContentRootPath + "\\Files";

            var filePath = @$"{apiFilePath}\\imgConvert.jpeg";
            if ( File.Exists(filePath) )
            {
                System.GC.Collect();
                System.GC.WaitForPendingFinalizers();
                File.Delete(filePath);
            }

            File.WriteAllBytes(filePath, bytes);

            return filePath;
        }
 //Convertir imagen a Array de bytes 
        private async Task<byte[]> ConvertImgToArrayBites(string imgPath)
        {
            byte[] imageByteArray;
            ;
            FileStream fileStream = new FileStream(imgPath, FileMode.Open, FileAccess.Read);
            using ( BinaryReader reader = new BinaryReader(fileStream) )
            {
                imageByteArray = new byte[reader.BaseStream.Length];
                for ( int i = 0; i < reader.BaseStream.Length; i++ )
                    imageByteArray[i] = reader.ReadByte();
            }
            fileStream.Close();
            System.GC.Collect();
            System.GC.WaitForPendingFinalizers();
            File.Delete(imgPath);

            return imageByteArray;
        }