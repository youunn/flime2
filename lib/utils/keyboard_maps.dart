import 'package:flutter/services.dart';

final logicalKeyToAndroidMap = kAndroidToLogicalKey.map((key, value) => MapEntry(value, key));

final specialLogicalKeyAndroidMap = <LogicalKeyboardKey, LogicalKeyboardKey>{
  LogicalKeyboardKey.quoteSingle: LogicalKeyboardKey.quote,
  LogicalKeyboardKey.tilde: LogicalKeyboardKey.backquote,
  LogicalKeyboardKey.quote: LogicalKeyboardKey.quote,
  LogicalKeyboardKey.backquote: LogicalKeyboardKey.backquote,
};

final specialLogicalKeyShiftMaskAndroidMap = <LogicalKeyboardKey, bool>{
  LogicalKeyboardKey.quoteSingle: false,
  LogicalKeyboardKey.tilde: true,
  LogicalKeyboardKey.quote: true,
  LogicalKeyboardKey.backquote: false,
};

// final logicalKeyToGlfwMap = kGlfwToLogicalKey.map((key, value) => MapEntry(value, key));
// final logicalKeyToGtkMap = kGtkToLogicalKey.map((key, value) => MapEntry(value, key));

final logicalKeyToX11Map = <LogicalKeyboardKey, int>{
  // glfw
  LogicalKeyboardKey.space: 32,
  LogicalKeyboardKey.comma: 44,
  LogicalKeyboardKey.minus: 45,
  LogicalKeyboardKey.period: 46,
  LogicalKeyboardKey.slash: 47,
  LogicalKeyboardKey.digit0: 48,
  LogicalKeyboardKey.digit1: 49,
  LogicalKeyboardKey.digit2: 50,
  LogicalKeyboardKey.digit3: 51,
  LogicalKeyboardKey.digit4: 52,
  LogicalKeyboardKey.digit5: 53,
  LogicalKeyboardKey.digit6: 54,
  LogicalKeyboardKey.digit7: 55,
  LogicalKeyboardKey.digit8: 56,
  LogicalKeyboardKey.digit9: 57,
  LogicalKeyboardKey.semicolon: 59,
  LogicalKeyboardKey.equal: 61,
  LogicalKeyboardKey.keyA: 65,
  LogicalKeyboardKey.keyB: 66,
  LogicalKeyboardKey.keyC: 67,
  LogicalKeyboardKey.keyD: 68,
  LogicalKeyboardKey.keyE: 69,
  LogicalKeyboardKey.keyF: 70,
  LogicalKeyboardKey.keyG: 71,
  LogicalKeyboardKey.keyH: 72,
  LogicalKeyboardKey.keyI: 73,
  LogicalKeyboardKey.keyJ: 74,
  LogicalKeyboardKey.keyK: 75,
  LogicalKeyboardKey.keyL: 76,
  LogicalKeyboardKey.keyM: 77,
  LogicalKeyboardKey.keyN: 78,
  LogicalKeyboardKey.keyO: 79,
  LogicalKeyboardKey.keyP: 80,
  LogicalKeyboardKey.keyQ: 81,
  LogicalKeyboardKey.keyR: 82,
  LogicalKeyboardKey.keyS: 83,
  LogicalKeyboardKey.keyT: 84,
  LogicalKeyboardKey.keyU: 85,
  LogicalKeyboardKey.keyV: 86,
  LogicalKeyboardKey.keyW: 87,
  LogicalKeyboardKey.keyX: 88,
  LogicalKeyboardKey.keyY: 89,
  LogicalKeyboardKey.keyZ: 90,
  LogicalKeyboardKey.bracketLeft: 91,
  LogicalKeyboardKey.backslash: 92,
  LogicalKeyboardKey.bracketRight: 93,

  // gtk
  LogicalKeyboardKey.intlYen: 165,
  LogicalKeyboardKey.eraseEof: 64774,
  LogicalKeyboardKey.attn: 64782,
  LogicalKeyboardKey.copy: 64789,
  LogicalKeyboardKey.mediaPlay: 64790,
  LogicalKeyboardKey.exSel: 64795,
  LogicalKeyboardKey.printScreen: 64797,
  // LogicalKeyboardKey.altRight:  65027,
  LogicalKeyboardKey.groupNext: 65032,
  LogicalKeyboardKey.groupPrevious: 65034,
  LogicalKeyboardKey.groupFirst: 65036,
  LogicalKeyboardKey.groupLast: 65038,

  LogicalKeyboardKey.backspace: 65288,
  LogicalKeyboardKey.tab: 65289,
  LogicalKeyboardKey.clear: 65291,
  LogicalKeyboardKey.enter: 65293,
  LogicalKeyboardKey.pause: 65299,
  LogicalKeyboardKey.scrollLock: 65300,
  LogicalKeyboardKey.escape: 65307,

  LogicalKeyboardKey.kanjiMode: 65313,
  LogicalKeyboardKey.romaji: 65316,
  LogicalKeyboardKey.hiragana: 65317,
  LogicalKeyboardKey.katakana: 65318,
  LogicalKeyboardKey.hiraganaKatakana: 65319,
  LogicalKeyboardKey.zenkaku: 65320,
  LogicalKeyboardKey.hankaku: 65321,
  LogicalKeyboardKey.zenkakuHankaku: 65322,
  LogicalKeyboardKey.eisu: 65327,
  LogicalKeyboardKey.hangulMode: 65329,
  LogicalKeyboardKey.hanjaMode: 65332,
  LogicalKeyboardKey.codeInput: 65335,
  LogicalKeyboardKey.singleCandidate: 65340,
  LogicalKeyboardKey.previousCandidate: 65342,

  LogicalKeyboardKey.home: 65360,
  LogicalKeyboardKey.arrowLeft: 65361,
  LogicalKeyboardKey.arrowUp: 65362,
  LogicalKeyboardKey.arrowRight: 65363,
  LogicalKeyboardKey.arrowDown: 65364,
  LogicalKeyboardKey.pageUp: 65365,
  LogicalKeyboardKey.pageDown: 65366,
  LogicalKeyboardKey.end: 65367,

  LogicalKeyboardKey.select: 65376,
  LogicalKeyboardKey.print: 65377,
  LogicalKeyboardKey.execute: 65378,
  LogicalKeyboardKey.insert: 65379,
  LogicalKeyboardKey.undo: 65381,
  LogicalKeyboardKey.redo: 65382,
  LogicalKeyboardKey.contextMenu: 65383,
  LogicalKeyboardKey.find: 65384,
  LogicalKeyboardKey.cancel: 65385,
  LogicalKeyboardKey.help: 65386,
  LogicalKeyboardKey.modeChange: 65406,
  LogicalKeyboardKey.numLock: 65407,

  LogicalKeyboardKey.f1: 65470,
  LogicalKeyboardKey.f2: 65471,
  LogicalKeyboardKey.f3: 65472,
  LogicalKeyboardKey.f4: 65473,
  LogicalKeyboardKey.f5: 65474,
  LogicalKeyboardKey.f6: 65475,
  LogicalKeyboardKey.f7: 65476,
  LogicalKeyboardKey.f8: 65477,
  LogicalKeyboardKey.f9: 65478,
  LogicalKeyboardKey.f10: 65479,
  LogicalKeyboardKey.f11: 65480,
  LogicalKeyboardKey.f12: 65481,
  LogicalKeyboardKey.f13: 65482,
  LogicalKeyboardKey.f14: 65483,
  LogicalKeyboardKey.f15: 65484,
  LogicalKeyboardKey.f16: 65485,
  LogicalKeyboardKey.f17: 65486,
  LogicalKeyboardKey.f18: 65487,
  LogicalKeyboardKey.f19: 65488,
  LogicalKeyboardKey.f20: 65489,
  LogicalKeyboardKey.f21: 65490,
  LogicalKeyboardKey.f22: 65491,
  LogicalKeyboardKey.f23: 65492,
  LogicalKeyboardKey.f24: 65493,

  LogicalKeyboardKey.shiftLeft: 65505,
  LogicalKeyboardKey.shiftRight: 65506,
  LogicalKeyboardKey.controlLeft: 65507,
  LogicalKeyboardKey.controlRight: 65508,
  LogicalKeyboardKey.capsLock: 65509,
  LogicalKeyboardKey.metaLeft: 65511,
  LogicalKeyboardKey.metaRight: 65512,
  LogicalKeyboardKey.altLeft: 65513,
  LogicalKeyboardKey.altRight: 65514,
  LogicalKeyboardKey.superKey: 65515,
  // LogicalKeyboardKey.superKey:  65516,
  LogicalKeyboardKey.hyper: 65517,
  // LogicalKeyboardKey.hyper:  65518,

  LogicalKeyboardKey.delete: 65535,

  LogicalKeyboardKey.numpadDecimal: 65439,
  LogicalKeyboardKey.numpadMultiply: 65450,
  LogicalKeyboardKey.numpadAdd: 65451,
  LogicalKeyboardKey.numpadSubtract: 65453,
  LogicalKeyboardKey.numpadDivide: 65455,
  LogicalKeyboardKey.numpad0: 65456,
  LogicalKeyboardKey.numpad1: 65457,
  LogicalKeyboardKey.numpad2: 65458,
  LogicalKeyboardKey.numpad3: 65459,
  LogicalKeyboardKey.numpad4: 65460,
  LogicalKeyboardKey.numpad5: 65461,
  LogicalKeyboardKey.numpad6: 65462,
  LogicalKeyboardKey.numpad7: 65463,
  LogicalKeyboardKey.numpad8: 65464,
  LogicalKeyboardKey.numpad9: 65465,
  LogicalKeyboardKey.numpadEqual: 65469,

  SmallLetter.keyA: 97,
  SmallLetter.keyB: 98,
  SmallLetter.keyC: 99,
  SmallLetter.keyD: 100,
  SmallLetter.keyE: 101,
  SmallLetter.keyF: 102,
  SmallLetter.keyG: 103,
  SmallLetter.keyH: 104,
  SmallLetter.keyI: 105,
  SmallLetter.keyJ: 106,
  SmallLetter.keyK: 107,
  SmallLetter.keyL: 108,
  SmallLetter.keyM: 109,
  SmallLetter.keyN: 110,
  SmallLetter.keyO: 111,
  SmallLetter.keyP: 112,
  SmallLetter.keyQ: 113,
  SmallLetter.keyR: 114,
  SmallLetter.keyS: 115,
  SmallLetter.keyT: 116,
  SmallLetter.keyU: 117,
  SmallLetter.keyV: 118,
  SmallLetter.keyW: 119,
  SmallLetter.keyX: 120,
  SmallLetter.keyY: 121,
  SmallLetter.keyZ: 122,

  // other
  LogicalKeyboardKey.quoteSingle: 0x27,
  LogicalKeyboardKey.tilde: 0x7e,

  // shift
  LogicalKeyboardKey.backquote: 0x60,
  LogicalKeyboardKey.exclamation: 0x21,
  LogicalKeyboardKey.at: 0x40,
  LogicalKeyboardKey.numberSign: 0x23,
  LogicalKeyboardKey.dollar: 0x24,
  LogicalKeyboardKey.percent: 0x25,
  LogicalKeyboardKey.caret: 0x5e,
  LogicalKeyboardKey.ampersand: 0x26,
  LogicalKeyboardKey.asterisk: 0x2a,
  LogicalKeyboardKey.parenthesisLeft: 0x28,
  LogicalKeyboardKey.parenthesisRight: 0x29,
  LogicalKeyboardKey.underscore: 0x5f,
  LogicalKeyboardKey.add: 0x2b,
  LogicalKeyboardKey.braceLeft: 0x7b,
  LogicalKeyboardKey.braceRight: 0x7d,
  LogicalKeyboardKey.bar: 0x7c,
  LogicalKeyboardKey.colon: 0x3b,
  LogicalKeyboardKey.quote: 0x22,
  LogicalKeyboardKey.less: 0x3c,
  LogicalKeyboardKey.greater: 0x3e,
  LogicalKeyboardKey.question: 0x3f,
};

class SmallLetter extends LogicalKeyboardKey {
  const SmallLetter(super.keyId);

  @override
  String get keyLabel => _smallLetterKeyLabels[keyId] ?? '';

  static const SmallLetter keyA = SmallLetter(0x00300000000 | 0x00000000061);
  static const SmallLetter keyB = SmallLetter(0x00300000000 | 0x00000000062);
  static const SmallLetter keyC = SmallLetter(0x00300000000 | 0x00000000063);
  static const SmallLetter keyD = SmallLetter(0x00300000000 | 0x00000000064);
  static const SmallLetter keyE = SmallLetter(0x00300000000 | 0x00000000065);
  static const SmallLetter keyF = SmallLetter(0x00300000000 | 0x00000000066);
  static const SmallLetter keyG = SmallLetter(0x00300000000 | 0x00000000067);
  static const SmallLetter keyH = SmallLetter(0x00300000000 | 0x00000000068);
  static const SmallLetter keyI = SmallLetter(0x00300000000 | 0x00000000069);
  static const SmallLetter keyJ = SmallLetter(0x00300000000 | 0x0000000006a);
  static const SmallLetter keyK = SmallLetter(0x00300000000 | 0x0000000006b);
  static const SmallLetter keyL = SmallLetter(0x00300000000 | 0x0000000006c);
  static const SmallLetter keyM = SmallLetter(0x00300000000 | 0x0000000006d);
  static const SmallLetter keyN = SmallLetter(0x00300000000 | 0x0000000006e);
  static const SmallLetter keyO = SmallLetter(0x00300000000 | 0x0000000006f);
  static const SmallLetter keyP = SmallLetter(0x00300000000 | 0x00000000070);
  static const SmallLetter keyQ = SmallLetter(0x00300000000 | 0x00000000071);
  static const SmallLetter keyR = SmallLetter(0x00300000000 | 0x00000000072);
  static const SmallLetter keyS = SmallLetter(0x00300000000 | 0x00000000073);
  static const SmallLetter keyT = SmallLetter(0x00300000000 | 0x00000000074);
  static const SmallLetter keyU = SmallLetter(0x00300000000 | 0x00000000075);
  static const SmallLetter keyV = SmallLetter(0x00300000000 | 0x00000000076);
  static const SmallLetter keyW = SmallLetter(0x00300000000 | 0x00000000077);
  static const SmallLetter keyX = SmallLetter(0x00300000000 | 0x00000000078);
  static const SmallLetter keyY = SmallLetter(0x00300000000 | 0x00000000079);
  static const SmallLetter keyZ = SmallLetter(0x00300000000 | 0x0000000007a);

  static const Map<int, String> _smallLetterKeyLabels = <int, String>{
    0x00300000061: 'a',
    0x00300000062: 'b',
    0x00300000063: 'c',
    0x00300000064: 'd',
    0x00300000065: 'e',
    0x00300000066: 'f',
    0x00300000067: 'g',
    0x00300000068: 'h',
    0x00300000069: 'i',
    0x0030000006a: 'j',
    0x0030000006b: 'k',
    0x0030000006c: 'l',
    0x0030000006d: 'm',
    0x0030000006e: 'n',
    0x0030000006f: 'o',
    0x00300000070: 'p',
    0x00300000071: 'q',
    0x00300000072: 'r',
    0x00300000073: 's',
    0x00300000074: 't',
    0x00300000075: 'u',
    0x00300000076: 'v',
    0x00300000077: 'w',
    0x00300000078: 'x',
    0x00300000079: 'y',
    0x0030000007a: 'z',
  };
}

final upperCaseMap = <SmallLetter, LogicalKeyboardKey>{
  SmallLetter.keyA: LogicalKeyboardKey.keyA,
  SmallLetter.keyB: LogicalKeyboardKey.keyB,
  SmallLetter.keyC: LogicalKeyboardKey.keyC,
  SmallLetter.keyD: LogicalKeyboardKey.keyD,
  SmallLetter.keyE: LogicalKeyboardKey.keyE,
  SmallLetter.keyF: LogicalKeyboardKey.keyF,
  SmallLetter.keyG: LogicalKeyboardKey.keyG,
  SmallLetter.keyH: LogicalKeyboardKey.keyH,
  SmallLetter.keyI: LogicalKeyboardKey.keyI,
  SmallLetter.keyJ: LogicalKeyboardKey.keyJ,
  SmallLetter.keyK: LogicalKeyboardKey.keyK,
  SmallLetter.keyL: LogicalKeyboardKey.keyL,
  SmallLetter.keyM: LogicalKeyboardKey.keyM,
  SmallLetter.keyN: LogicalKeyboardKey.keyN,
  SmallLetter.keyO: LogicalKeyboardKey.keyO,
  SmallLetter.keyP: LogicalKeyboardKey.keyP,
  SmallLetter.keyQ: LogicalKeyboardKey.keyQ,
  SmallLetter.keyR: LogicalKeyboardKey.keyR,
  SmallLetter.keyS: LogicalKeyboardKey.keyS,
  SmallLetter.keyT: LogicalKeyboardKey.keyT,
  SmallLetter.keyU: LogicalKeyboardKey.keyU,
  SmallLetter.keyV: LogicalKeyboardKey.keyV,
  SmallLetter.keyW: LogicalKeyboardKey.keyW,
  SmallLetter.keyX: LogicalKeyboardKey.keyX,
  SmallLetter.keyY: LogicalKeyboardKey.keyY,
  SmallLetter.keyZ: LogicalKeyboardKey.keyZ,
};

final withShiftMap = <LogicalKeyboardKey, LogicalKeyboardKey>{
  LogicalKeyboardKey.backquote: LogicalKeyboardKey.tilde,
  LogicalKeyboardKey.exclamation: LogicalKeyboardKey.digit1,
  LogicalKeyboardKey.at: LogicalKeyboardKey.digit2,
  LogicalKeyboardKey.numberSign: LogicalKeyboardKey.digit3,
  LogicalKeyboardKey.dollar: LogicalKeyboardKey.digit4,
  LogicalKeyboardKey.percent: LogicalKeyboardKey.digit5,
  LogicalKeyboardKey.caret: LogicalKeyboardKey.digit6,
  LogicalKeyboardKey.ampersand: LogicalKeyboardKey.digit7,
  LogicalKeyboardKey.asterisk: LogicalKeyboardKey.digit8,
  LogicalKeyboardKey.parenthesisLeft: LogicalKeyboardKey.digit9,
  LogicalKeyboardKey.parenthesisRight: LogicalKeyboardKey.digit0,
  LogicalKeyboardKey.underscore: LogicalKeyboardKey.minus,
  LogicalKeyboardKey.add: LogicalKeyboardKey.equal,
  LogicalKeyboardKey.braceLeft: LogicalKeyboardKey.bracketLeft,
  LogicalKeyboardKey.braceRight: LogicalKeyboardKey.bracketRight,
  LogicalKeyboardKey.bar: LogicalKeyboardKey.backslash,
  LogicalKeyboardKey.colon: LogicalKeyboardKey.semicolon,
  LogicalKeyboardKey.quote: LogicalKeyboardKey.quoteSingle,
  LogicalKeyboardKey.less: LogicalKeyboardKey.comma,
  LogicalKeyboardKey.greater: LogicalKeyboardKey.period,
  LogicalKeyboardKey.question: LogicalKeyboardKey.slash,
};

// TODO: label to logical key map
const numberToLogicalKeyMap = <int, LogicalKeyboardKey>{
  0: LogicalKeyboardKey.digit0,
  1: LogicalKeyboardKey.digit1,
  2: LogicalKeyboardKey.digit2,
  3: LogicalKeyboardKey.digit3,
  4: LogicalKeyboardKey.digit4,
  5: LogicalKeyboardKey.digit5,
  6: LogicalKeyboardKey.digit6,
  7: LogicalKeyboardKey.digit7,
  8: LogicalKeyboardKey.digit8,
  9: LogicalKeyboardKey.digit9,
};

const upperACode = 65;
const lowerACode = 97;
const lowerZCode = 122;
const caseDiff = lowerACode - upperACode;
