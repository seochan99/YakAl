import { DefaultTheme, css } from "styled-components";

const colors = {
  indigo: {
    50: "#f2f6fc",
    100: "#e2ebf7",
    200: "#cbddf2",
    300: "#a8c7e8",
    400: "#7eaadc",
    500: "#5f8ed2",
    600: "#4a73c4",
    700: "#4162b4",
    800: "#3a5193",
    900: "#334675",
    950: "#232c48",
  },
  flamingo: {
    50: "#fef3f2",
    100: "#ffe5e1",
    200: "#ffcec8",
    300: "#ff9e91",
    400: "#fd7d6c",
    500: "#f5543e",
    600: "#e23720",
    700: "#be2b17",
    800: "#9d2717",
    900: "#82261a",
    950: "#470f08",
  },
  mojo: {
    50: "#fdf4f3",
    100: "#fbe6e5",
    200: "#f8d2d0",
    300: "#f2b2af",
    400: "#e88681",
    500: "#db5f58",
    600: "#c23f38",
    700: "#a6352f",
    800: "#8a2f2a",
    900: "#732d29",
    950: "#3e1311",
  },
  yellow: {
    50: "#feffe7",
    100: "#faffc1",
    200: "#f9ff86",
    300: "#feff41",
    400: "#fff40d",
    500: "#fee500",
    600: "#d1aa00",
    700: "#a67b02",
    800: "#895f0a",
    900: "#744e0f",
    950: "#442904",
  },
  purple: {
    50: "#f6f3ff",
    100: "#f0e8ff",
    200: "#e1d5ff",
    300: "#c7acff",
    400: "#b388fd",
    500: "#9c58fa",
    600: "#9135f2",
    700: "#8223de",
    800: "#6c1dba",
    900: "#5a1a98",
    950: "#370e67",
  },
  white: "#FFFFFF",
  gray: {
    100: "#eaeaef",
    200: "#dedfe5",
    300: "#c2c4ce",
    400: "#a4a7b6",
    500: "#8d8fa4",
    600: "#7c7c94",
    700: "#706f86",
    800: "#5f5e6f",
    900: "#4d4d5b",
  },
  black: "#000000",
};

export type ColorsTypes = typeof colors;

interface Font {
  weight: number;
  size: number;
  lineHeight: number;
}

function FONT({ weight, size, lineHeight }: Font): string {
  return `
    font-family: "Pretendard";
    font-weight : ${weight};
    font-size : ${size}px;
    line-height : ${lineHeight}px;
    `;
}

const fonts = {
  extra_bold: FONT({ weight: 800, size: 20, lineHeight: 32 }),
  bold: FONT({ weight: 700, size: 16, lineHeight: 19 }),
  medium: FONT({ weight: 500, size: 16, lineHeight: 19 }),
  regular: FONT({ weight: 400, size: 16, lineHeight: 19 }),
  nav: FONT({ weight: 600, size: 18, lineHeight: 29 }),
  tutorial_head: FONT({ weight: 700, size: 24, lineHeight: 24 }),
  tutorial_strong: FONT({ weight: 700, size: 20, lineHeight: 20 }),
  tutorial_sub: FONT({ weight: 500, size: 18, lineHeight: 18 }),
  tutorial_text: FONT({ weight: 500, size: 13, lineHeight: 20 }),
  category_strong: FONT({ weight: 800, size: 20, lineHeight: 28 }),
  category_sub: FONT({ weight: 500, size: 20, lineHeight: 28 }),
  option_content: FONT({ weight: 500, size: 13, lineHeight: 13 }),
  user: FONT({ weight: 500, size: 18, lineHeight: 18 }),
  PretendardMedium: css`
    font-family: "Pretendard";
    font-style: normal;
    font-weight: 500;
    letter-spacing: 20;
  `,
  PretendardBold: css`
    font-family: "Pretendard";
    font-style: normal;
    font-weight: 900;
    letter-spacing: 20;
  `,
  KCCEunyoung: css`
    font-family: "KCC-eunyoung";
    font-style: normal;
    font-weight: 500;
    letter-spacing: 20;
  `,
  GmarketSansMedium: css`
    font-family: "GmarketSansMedium";
    font-style: normal;
    font-weight: 500;
    letter-spacing: 20;
  `,
  SCoreDream1: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 200;
    letter-spacing: 20;
  `,
  SCoreDream2: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 300;
    letter-spacing: 20;
  `,
  SCoreDream3: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 400;
    letter-spacing: 20;
  `,
  SCoreDream4: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 500;
    letter-spacing: 20;
  `,
  SCoreDream5: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 600;
    letter-spacing: 20;
  `,
  SCoreDream6: css`
    font-family: "S-CoreDream-3Light";
    font-style: normal;
    font-weight: 700;
    letter-spacing: 20;
  `,
};

export type FontsTypes = typeof fonts;

export const theme: DefaultTheme = {
  colors,
  fonts,
};
