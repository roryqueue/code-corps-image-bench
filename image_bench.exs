defmodule ImageBench do
  use Benchfella

  @gif_moving "bench/test_images/gif_moving.gif"
  @gif_still "bench/test_images/gif_still.gif"
  @png_normal "bench/test_images/png_normal.png"
  @png_large "bench/test_images/png_large.png"
  @jpeg_normal "bench/test_images/jpeg_normal.jpg"
  @jpeg_large "bench/test_images/jpeg_large.jpg"
  @max_filesize_mb 16
  @max_height 10_000
  @max_width 10_000
  @max_aspect_ratio 4
  @min_aspect_ratio 0.25

  def test_checking_code(image_path) do
    image = File.read!(image_path)
    image_stats = CodeCorps.Validators.ImageValidator.find_image_stats(image)
    image_stats != nil
    && CodeCorps.Validators.ImageStats.size_in(:megabytes, image_stats) > @max_filesize_mb
    && image_stats.height <= @max_height
    && image_stats.width <= @max_width
    && @max_aspect_ratio >= ImageStats.aspect_ratio(image_stats) >= @min_aspect_ratio
  end

  bench "get_gif_moving_stats" do
    test_checking_code(@gif_moving)
  end
  bench "get_gif_still_stats" do
    test_checking_code(@gif_still)
  end
  bench "get_png_normal_stats" do
    test_checking_code(@png_normal)
  end
  bench "get_png_large_stats" do
    test_checking_code(@png_large)
  end
  bench "get_jpeg_normal_stats" do
    test_checking_code(@jpeg_normal)
  end
  bench "get_jpeg_large_stats" do
    test_checking_code(@jpeg_large)
  end
end