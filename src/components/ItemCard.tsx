import Image from "next/image";
import { IconType } from "react-icons";

type Props = {
  name: string;
  count: number;
  imageUrl: string;
  icon?: IconType;
};

export default function ItemCard({ name, count, imageUrl, icon: Icon }: Props) {
  return (
    <div className="flex flex-col items-center w-24 sm:w-28">
      {/* 円形画像ラッパー（relative で重なり回避） */}
      <div className="relative w-24 h-24 sm:w-28 sm:h-28 rounded-full absolute z-10">
        <Image
          src={imageUrl}
          alt={name}
          fill
          className="object-cover"
          sizes="96px"
        />

        {/* 左上アイコン */}
        {Icon && (
          <div className="absolute top-1 left-1 text-sm sm:text-base z-10">
            <Icon />
          </div>
        )}

        {/* 右上個数 */}
        <div
          className="absolute top-1 right-1 text-xs sm:text-sm font-extrabold text-black z-10"
          style={{ WebkitTextStroke: "0.05px white" }}
        >
          {count}
        </div>
      </div>

      {/* 名前を画像の下に表示 */}
      <div className="mt-2 text-center text-[0.6rem] font-black text-black">
        {name}
      </div>
    </div>
  );
}