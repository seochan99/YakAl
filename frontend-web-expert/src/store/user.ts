import { ESex } from "@/type/sex";

export type TUser = {
  id: number;
  name: string;
  sex: ESex;
  birthday: Date;
};

export type TSpecialNote = {
  id: number;
  title: string;
  description: string;
  recorded_at: Date;
};

export const users: TUser[] = [
  {
    id: 1,
    name: "홍길동1",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 2,
    name: "홍길동2",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 3,
    name: "홍길동3",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 4,
    name: "홍길동4",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 5,
    name: "홍길동5",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 6,
    name: "홍길동6",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 7,
    name: "홍길동7",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 8,
    name: "홍길동8",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 9,
    name: "홍길동9",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
  {
    id: 10,
    name: "홍길동10",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
  },
];
