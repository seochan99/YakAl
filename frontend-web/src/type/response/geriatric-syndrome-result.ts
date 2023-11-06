export type TGeriatricSyndromeResult = {
  mna: number[] | null;
  adl: boolean[] | null;
  delirium: boolean[] | null;
  audiovisual: {
    useGlasses: boolean | null;
    useHearingAid: boolean | null;
  } | null;
  fall: number[][] | null;
};
