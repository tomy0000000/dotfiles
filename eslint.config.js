const { default: json } = require("@eslint/json")

module.exports = [
  {
    plugins: { json },
    files: ["**/*.json"],
    language: "json/json5",
    rules: {
      "json/no-duplicate-keys": "error",
      "json/no-empty-keys": "error",
      "json/sort-keys": "error",
    },
  },
]
