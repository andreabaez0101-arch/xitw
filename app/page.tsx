"use client"

import { useState } from "react"

// Liquid Glass Inventory Preview - v1.0
export default function InventoryPreview() {
  const [activeCategory, setActiveCategory] = useState(0)
  const [currentValues, setCurrentValues] = useState({
    color: "Midnight Black",
    size: "Medium",
    style: "Classic"
  })

  const categories = [
    { name: "Clothing", icon: "👔" },
    { name: "Weapons", icon: "🔫" },
    { name: "Vehicles", icon: "🚗" },
    { name: "Props", icon: "📦" },
    { name: "Accessories", icon: "⌚" },
  ]

  const items = [
    { title: "Premium Jacket", subtitle: "High quality leather jacket", options: ["Black", "Brown", "Navy"] },
    { title: "Designer Pants", subtitle: "Slim fit modern design", options: ["S", "M", "L", "XL"] },
    { title: "Sport Shoes", subtitle: "Comfort and style combined", options: ["Classic", "Sport", "Casual"] },
  ]

  return (
    <div className="relative w-full h-screen overflow-hidden font-sans">
      {/* Background */}
      <div 
        className="absolute inset-0"
        style={{
          background: "linear-gradient(135deg, rgba(20, 20, 22, 0.95) 0%, rgba(30, 30, 35, 0.7) 50%, rgba(20, 20, 22, 0.98) 100%)",
        }}
      />
      
      {/* Ambient light effects */}
      <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-white/5 rounded-full blur-[100px]" />
      <div className="absolute bottom-1/4 right-1/4 w-80 h-80 bg-white/3 rounded-full blur-[80px]" />

      {/* Categories Sidebar */}
      <div 
        className="absolute left-6 top-1/2 -translate-y-1/2 flex flex-col gap-2 p-3 rounded-[20px] z-10"
        style={{
          background: "rgba(20, 20, 22, 0.18)",
          backdropFilter: "blur(20px)",
          WebkitBackdropFilter: "blur(20px)",
          border: "1px solid rgba(255, 255, 255, 0.08)",
          boxShadow: "0 8px 32px rgba(0, 0, 0, 0.3), inset 0 1px 0 rgba(255, 255, 255, 0.15)",
        }}
      >
        {categories.map((cat, i) => (
          <button
            key={i}
            onClick={() => setActiveCategory(i)}
            className={`relative w-14 h-14 rounded-[14px] flex items-center justify-center text-xl transition-all duration-300 overflow-hidden ${
              activeCategory === i 
                ? "scale-105" 
                : "hover:scale-105"
            }`}
            style={{
              background: activeCategory === i 
                ? "rgba(255, 255, 255, 0.15)" 
                : "rgba(20, 20, 22, 0.45)",
              border: `1px solid ${activeCategory === i ? "rgba(255, 255, 255, 0.25)" : "rgba(255, 255, 255, 0.08)"}`,
              boxShadow: activeCategory === i 
                ? "0 0 20px rgba(255, 255, 255, 0.15), inset 0 1px 0 rgba(255, 255, 255, 0.2)" 
                : "none",
            }}
          >
            {/* Glass reflection */}
            <div 
              className="absolute top-0 left-0 right-0 h-1/2 pointer-events-none rounded-t-[14px]"
              style={{
                background: "linear-gradient(180deg, rgba(255, 255, 255, 0.08), transparent)",
              }}
            />
            <span className="relative z-10 filter grayscale opacity-70 hover:grayscale-0 hover:opacity-100 transition-all">
              {cat.icon}
            </span>
          </button>
        ))}
      </div>

      {/* Main Panel */}
      <div 
        className="absolute left-28 top-1/2 -translate-y-1/2 w-[420px] h-[75%] rounded-[24px] p-6 overflow-y-auto z-10"
        style={{
          background: "rgba(20, 20, 22, 0.18)",
          backdropFilter: "blur(20px)",
          WebkitBackdropFilter: "blur(20px)",
          border: "1px solid rgba(255, 255, 255, 0.08)",
          boxShadow: "0 8px 32px rgba(0, 0, 0, 0.3)",
        }}
      >
        {/* Panel glass reflection */}
        <div 
          className="absolute top-0 left-0 right-0 h-20 pointer-events-none rounded-t-[24px]"
          style={{
            background: "linear-gradient(180deg, rgba(255, 255, 255, 0.05), transparent)",
          }}
        />
        
        <div className="relative space-y-4">
          {items.map((item, i) => (
            <div 
              key={i}
              className="p-4 rounded-[16px] transition-all duration-300 hover:scale-[1.02]"
              style={{
                background: "rgba(255, 255, 255, 0.03)",
                border: "1px solid rgba(255, 255, 255, 0.08)",
              }}
            >
              <h3 className="text-white font-semibold text-lg mb-1">{item.title}</h3>
              <p className="text-white/60 text-sm mb-4">{item.subtitle}</p>
              
              {/* Options Selector */}
              <div 
                className="flex items-center rounded-[12px] overflow-hidden"
                style={{
                  background: "rgba(20, 20, 22, 0.45)",
                  border: "1px solid rgba(255, 255, 255, 0.08)",
                }}
              >
                <button 
                  className="w-10 h-10 flex items-center justify-center text-white/70 hover:text-white hover:bg-white/10 transition-all"
                  style={{ borderRight: "1px solid rgba(255, 255, 255, 0.08)" }}
                >
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <div className="flex-1 text-center text-white text-sm font-medium py-2">
                  {item.options[0]}
                </div>
                <button 
                  className="w-10 h-10 flex items-center justify-center text-white/70 hover:text-white hover:bg-white/10 transition-all"
                  style={{ borderLeft: "1px solid rgba(255, 255, 255, 0.08)" }}
                >
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
            </div>
          ))}

          {/* Slider Control */}
          <div 
            className="p-4 rounded-[16px]"
            style={{
              background: "rgba(255, 255, 255, 0.03)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <p className="text-white/70 text-xs uppercase tracking-wider mb-3">Zoom Distance</p>
            <input 
              type="range" 
              className="w-full h-1 rounded-full appearance-none cursor-pointer"
              style={{
                background: "rgba(255, 255, 255, 0.15)",
              }}
            />
          </div>
        </div>
      </div>

      {/* Header */}
      <div 
        className="absolute top-6 right-8 px-6 py-4 rounded-[18px] z-10"
        style={{
          background: "rgba(20, 20, 22, 0.18)",
          backdropFilter: "blur(20px)",
          WebkitBackdropFilter: "blur(20px)",
          border: "1px solid rgba(255, 255, 255, 0.08)",
          boxShadow: "0 8px 32px rgba(0, 0, 0, 0.3)",
        }}
      >
        {/* Header glass reflection */}
        <div 
          className="absolute top-0 left-0 right-0 h-1/2 pointer-events-none rounded-t-[18px]"
          style={{
            background: "linear-gradient(180deg, rgba(255, 255, 255, 0.04), transparent)",
          }}
        />
        <p className="text-white/80 text-sm mb-1 relative">Welcome back</p>
        <h2 
          className="text-2xl font-semibold uppercase tracking-wider relative"
          style={{
            background: "linear-gradient(135deg, #ffffff 0%, rgba(255, 255, 255, 0.7) 100%)",
            WebkitBackgroundClip: "text",
            WebkitTextFillColor: "transparent",
            backgroundClip: "text",
          }}
        >
          {categories[activeCategory].name}
        </h2>
      </div>

      {/* Bottom Controls */}
      <div className="absolute bottom-6 left-8 right-8 flex justify-between items-end z-10">
        {/* Keys Help */}
        <div 
          className="flex gap-6 px-5 py-3 rounded-[14px]"
          style={{
            background: "rgba(20, 20, 22, 0.18)",
            backdropFilter: "blur(20px)",
            WebkitBackdropFilter: "blur(20px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <div className="flex items-center gap-2">
            <div className="w-6 h-6 rounded bg-white/10 flex items-center justify-center">
              <span className="text-white/70 text-xs">←→</span>
            </div>
            <span className="text-white/70 text-xs uppercase tracking-wider">Rotate</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-6 h-6 rounded bg-white/10 flex items-center justify-center">
              <span className="text-white/70 text-xs">↑↓</span>
            </div>
            <span className="text-white/70 text-xs uppercase tracking-wider">Height</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-6 h-6 rounded bg-white/10 flex items-center justify-center">
              <span className="text-white/70 text-xs">⚙</span>
            </div>
            <span className="text-white/70 text-xs uppercase tracking-wider">Zoom</span>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="flex gap-3">
          <button 
            className="relative px-8 py-3 rounded-[14px] text-white font-medium text-sm uppercase tracking-wider transition-all duration-300 hover:-translate-y-0.5 overflow-hidden"
            style={{
              background: "rgba(20, 20, 22, 0.18)",
              backdropFilter: "blur(20px)",
              WebkitBackdropFilter: "blur(20px)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <div 
              className="absolute top-0 left-0 right-0 h-1/2 pointer-events-none rounded-t-[14px]"
              style={{
                background: "linear-gradient(180deg, rgba(255, 255, 255, 0.08), transparent)",
              }}
            />
            <span className="relative flex items-center gap-2">
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
              </svg>
              Buy
            </span>
          </button>
          <button 
            className="px-8 py-3 rounded-[14px] text-white/70 hover:text-white font-medium text-sm uppercase tracking-wider transition-all duration-300 hover:-translate-y-0.5"
            style={{
              background: "rgba(20, 20, 22, 0.45)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <span className="flex items-center gap-2">
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
              Cancel
            </span>
          </button>
          <button 
            className="w-12 h-12 rounded-[14px] text-white/70 hover:text-white flex items-center justify-center transition-all duration-300 hover:-translate-y-0.5"
            style={{
              background: "rgba(20, 20, 22, 0.18)",
              backdropFilter: "blur(20px)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16m-7 6h7" />
            </svg>
          </button>
        </div>
      </div>
    </div>
  )
}
