# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Siri.destroy_all
Siri.create([
    {
        name: "MPESA_API_KEY",
        value: "a0rdeuPwoSqGv0HIlGBqZeMEocwIfjha"
    },
    {
        name: "MPESA_API_SECRET",
        value: "GC2ScUskImTOSaVR"
    },
    {
        name: "MPESA_API_PASSKEY",
        value: "b87283b3be82ed37fdfbed3209156575757720419a85088aec920583d05bcabc"
    },
    {
        name: "MPESA_SANDBOX_API_KEY",
        value: "TrnEPlNA2DD32e81MwGuqFm4Buliif5c"
    },
    {
        name: "MPESA_SANDBOX_API_SECRET",
        value: "qz9R5oXJAA3IH3yu"
    },
    {
        name: "MPESA_SANDBOX_API_PASSKEY",
        value: "b87283b3be82ed37fdfbed3209156575757720419a85088aec920583d05bcabc"
    },
    {
        name: "MPESA_B2C_API_KEY",
        value: "H9sp7IZjvZofvKIqmbDMFGu39N95FOEj"
    },
    {
        name: "MPESA_B2C_API_SECRET",
        value: "Rv52lKuXA0jfHBgE"
    },
    {
        name: "MPESA_B2C_API_PASSKEY",
        value: "mdlhTIiKm9B2y9gLxqSXvK/a7IPzGfCfLxU4lPcBMh4ZSiEuVElydgkofl6dJTbHv4rgdPPz4+16JoWWrG/g0rPv6QWlBLnUpAroZgIrN/vLHuMGPXpUVUDV/zNXLq6LppXfOTIRWTzFex2KpBqcQInl2/AXu2WAUN+l3kp+b8S/cEgAF0vGmH8qKS210W1fguTX11GxVdR+hhCoJSioCVtKYeRRyJ7IbgJUd1P7LkkCicM0QMP6A6pa6MWqfS14uHZhziQZPkjgZCOIuRx7MHHDebyjOPR4LEtYO9c0/1A4tBpVPCdOT+vtUJ1I5jBbg0ipKTBv63dM0FK9H1y2Cw=="
    },
    {
        name: "C2B_PAYBILL",
        value: "4072015"
    },
    {
        name: "B2C_PAYBILL",
        value: "3012169"
    },
    {
        name: "C2B_USERNAME",
        value: "sombo"
    },
    {
        name: "B2C_USERNAME",
        value: "sombob2c"
    },
    {
        name: "BASE_URL",
        value: "https://api.safaricom.co.ke"
    },
    {
        name: "TIMEOUT_URL",
        value: "https://prycely.com/validation"
    },
    {
        name: "RESULT_URL",
        value: "https://prycely.com/b2c"
    },
    {
        name: "CONFIRMATION_URL",
        value: "https://prycely.com/thecalls/c2b"
    },
    {
        name: "VALIDATION_URL",
        value: "https://prycely.com/thecalls/validation"
    },
    {
        name: "STK_CALLBACK",
        value: "https://prycely.com/stk-callback"
    }
])

p "Created #{Siri.count} Kronus"